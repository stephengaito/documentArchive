import { Component } from '@angular/core';
import { RouteConfig, ROUTER_DIRECTIVES, ROUTER_PROVIDERS }
  from '@angular/router-deprecated';

import { LanguageService }    from './language.service';
import { LanguagesComponent } from './languages.component';

@Component({
  selector: 'dse-app',
  directives: [ ROUTER_DIRECTIVES ],
  providers: [ ROUTER_PROVIDERS, LanguageService ],
  template: `
    <h1>{{title}}</h1>
    <nav>
      <a [routerLink]="['Languages']">Languages</a>
    </nav>
    <router-outlet></router-outlet>
  `
})

@RouteConfig([
  { path: '/languages',
    name: 'Languages',
    component: LanguagesComponent }
])

export class AppComponent {
  title = 'diSimplicial Explorer';
}
