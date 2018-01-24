#ifndef JOYLOL_HASH_MAP_H_INCLUDED
#define JOYLOL_HASH_MAP_H_INCLUDED

/****************************************************************************
MIT License

Copyright (c) 2017 cofinite (https://github.com/cofinite)
Modifications Copyright (c) 2018 PerceptiSys Ltd (Stephen Gaito)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*****************************************************************************

Originally taken from the file: hash_map.h
in the GitHub project: https://github.com/cofinite/C-Type-Safe-Hash-Map
commit: 3195c1acc3453757622290e738761a0bf3308895
on: 2018-01-24

For a general discussion of how to use this hash map see:
  https://github.com/cofinite/C-Type-Safe-Hash-Map

Modifications:

1) Hashing of Pointers using "Knuth's Multiplicative Method" as discussed on
   https://gist.github.com/badboy/6267743#knuths-multiplicative-method and
   https://lowrey.me/exploring-knuths-multiplicative-hash-2/

2) Since our pointers are (usually) aligned on a 32 (64) bit boundary the
   lowest 2 (3) significant bits are (usually) zero... so we shift off the
   lowest 2 (3) bits. (We *should* rotate rather than simply shift... but we
   are shifting off zeros anyway).

3) Added ptrHash (using items (1) and (2) above) and ptrEquals.

4) Renamed HASH_MAP_H_INCLUDED to JOYLOL_HASH_MAP_H_INCLUDED

5) Renamed HASH_MAP_DEFINE to JOYLOL_HASH_MAP_DEFINE

6) Removed static keyword

7) PREFIX ## _get method now returns the value directly rather than a pointer

8) Added extra parentheses around arguments to the '&' operator in order to
   pass stricter gcc -Werror=parentheses tests .

*******************************************************************************/

#include <stdlib.h>

#define HASH_MAP_BASIC_HASH_CODE(x) (x)
#define HASH_MAP_BASIC_EQUALS(x, y) ((x) == (y))

#ifdef __LP64__
#define ptrHash(x)      ((((uint64_t)x)>>3)*2654435761)
#else
#define ptrHash(x)      ((((uint32_t)x)>>2)*2654435761)
#endif
#define ptrEquals(x, y) ((x) == (y))

#define JOYLOL_HASH_MAP_DEFINE(HASH_MAP, KEY, VALUE, PREFIX, HASH_CODE, EQUALS) \
                                                                                \
typedef struct HASH_MAP ## _ENTRY {                                             \
        KEY key;                                                                \
        VALUE value;                                                            \
        char used;                                                              \
} HASH_MAP ## _ENTRY;                                                           \
                                                                                \
typedef struct HASH_MAP {                                                       \
        HASH_MAP ## _ENTRY* entry;                                              \
        unsigned lsize;                                                         \
        unsigned psize;                                                         \
        unsigned char max_lf_n;                                                 \
        unsigned char max_lf_d;                                                 \
} HASH_MAP;                                                                     \
                                                                                \
HASH_MAP* PREFIX ## _new(                                                       \
        unsigned initial_size,                                                  \
        unsigned char max_load_factor_numerator,                                \
        unsigned char max_load_factor_denominator                               \
) {                                                                             \
        HASH_MAP* this;                                                         \
                                                                                \
        this = malloc(sizeof *this);                                            \
        if (!this) return NULL;                                                 \
        this->lsize = 0;                                                        \
        this->max_lf_n = max_load_factor_numerator;                             \
        this->max_lf_d = max_load_factor_denominator;                           \
                                                                                \
        this->psize = 1;                                                        \
        while (this->psize < initial_size) this->psize <<= 1;                   \
        this->entry = calloc(this->psize, sizeof *this->entry);                 \
        if (!this->entry) {                                                     \
                free(this);                                                     \
                return NULL;                                                    \
        }                                                                       \
        return this;                                                            \
}                                                                               \
                                                                                \
void PREFIX ## _free(HASH_MAP* this) {                                          \
        if (!this) return;                                                      \
        free(this->entry);                                                      \
        free(this);                                                             \
}                                                                               \
                                                                                \
void PREFIX ## _put(HASH_MAP* this, KEY key, VALUE value) {                     \
        unsigned i, index;                                                      \
                                                                                \
        index = HASH_CODE(key) & (this->psize - 1);                             \
        for (i = this->psize; i; --i) {                                         \
                if (!this->entry[index].used) {                                 \
                        this->lsize += 1;                                       \
                        this->entry[index].key = key;                           \
                        this->entry[index].value = value;                       \
                        this->entry[index].used = 1;                            \
                        return;                                                 \
                }                                                               \
                if (EQUALS(key, this->entry[index].key)) {                      \
                        this->entry[index].value = value;                       \
                        return;                                                 \
                }                                                               \
                index = (index + 1) & (this->psize - 1);                        \
        }                                                                       \
}                                                                               \
                                                                                \
int PREFIX ## _rehash(HASH_MAP* this, unsigned new_size) {                      \
        unsigned i, old_size;                                                   \
        HASH_MAP ## _ENTRY* temp;                                               \
                                                                                \
        temp = this->entry;                                                     \
        this->entry = calloc(new_size, sizeof *this->entry);                    \
        if (!this->entry) {                                                     \
                this->entry = temp;                                             \
                return -1;                                                      \
        }                                                                       \
        old_size = this->psize;                                                 \
        this->psize = new_size;                                                 \
        this->lsize = 0;                                                        \
                                                                                \
        for (i = 0; i < old_size; ++i) {                                        \
                if (temp[i].used) {                                             \
                        PREFIX ## _put(this, temp[i].key, temp[i].value);       \
                }                                                               \
        }                                                                       \
        free(temp);                                                             \
        return 0;                                                               \
}                                                                               \
                                                                                \
int PREFIX ## _set(HASH_MAP* this, KEY key, VALUE value) {                      \
        if (                                                                    \
                this->max_lf_d * this->lsize >=                                 \
                this->max_lf_n * this->psize &&                                 \
                PREFIX ## _rehash(this, this->psize << 1)                       \
        ) {                                                                     \
                return -1;                                                      \
        }                                                                       \
        PREFIX ## _put(this, key, value);                                       \
        return 0;                                                               \
}                                                                               \
                                                                                \
VALUE PREFIX ## _get(HASH_MAP* this, KEY key) {                                 \
        unsigned i, index;                                                      \
                                                                                \
        index = HASH_CODE(key) & (this->psize - 1);                             \
        for (i = this->psize; i; --i) {                                         \
                if (!this->entry[index].used) {                                 \
                        return 0 /*NULL*/;                                      \
                }                                                               \
                if (EQUALS(key, this->entry[index].key)) {                      \
                        return this->entry[index].value;                        \
                }                                                               \
                index = (index + 1) & (this->psize - 1);                        \
        }                                                                       \
        return 0 /*NULL*/;                                                      \
}                                                                               \
                                                                                \
void PREFIX ## _delete(HASH_MAP* this, unsigned anchor) {                       \
        unsigned i, index, intended;                                            \
                                                                                \
        this->lsize -= 1;                                                       \
        this->entry[anchor].used = 0;                                           \
                                                                                \
        index = (anchor + 1) & (this->psize - 1);                               \
        for (i = this->psize; i; --i) {                                         \
                if (!this->entry[index].used) {                                 \
                        return;                                                 \
                }                                                               \
                intended =                                                      \
                  HASH_CODE(this->entry[index].key) & (this->psize - 1);        \
                if (                                                            \
                        (anchor < index) +                                      \
                        (intended > index) +                                    \
                        (intended <= anchor) > 1                                \
                ) {                                                             \
                        this->entry[anchor] = this->entry[index];               \
                        anchor = index;                                         \
                        this->entry[index].used = 0;                            \
                }                                                               \
                index = (index + 1) & (this->psize - 1);                        \
        }                                                                       \
}                                                                               \
                                                                                \
void PREFIX ## _remove(HASH_MAP* this, KEY key) {                               \
        unsigned i, index;                                                      \
                                                                                \
        index = HASH_CODE(key) & (this->psize - 1);                             \
        for (i = this->psize; i; --i) {                                         \
                if (!this->entry[index].used) {                                 \
                        return;                                                 \
                }                                                               \
                if (EQUALS(key, this->entry[index].key)) {                      \
                        PREFIX ## _delete(this, index);                         \
                        return;                                                 \
                }                                                               \
                index = (index + 1) & (this->psize - 1);                        \
        }                                                                       \
}

#endif /* JOYLOL_HASH_MAP_H_INCLUDED */
