import { Component, OnInit } from '@angular/core';

import { Language }        from './language';
import { LanguageService } from './language.service';

@Component({
  selector: 'ds-languages',
  template: `
    <h2>Languages</h2>
    <ul class="languages">
      <li *ngFor="let language of languages">
        {{language.name}}
      </li>
    </ul>
  `
})

export class LanguagesComponent implements OnInit {
  languages: Language[];

  constructor(
    private languageService: LanguageService 
  ) { }

  getLanguages() {
    this.languageService.getLanguages()
      .then(languages => this.languages = languages);
  }

  ngOnInit() {
    this.getLanguages();
  }

}
