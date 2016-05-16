import { Component } from '@angular/core';
import { RouteConfig, ROUTER_DIRECTIVES, ROUTER_PROVIDERS }
  from '@angular/router-deprecated';

import { Language }           from './language';
import { LanguageService }    from './language.service';
import { LanguagesComponent } from './languages.component';

@Component({
  selector: 'dse-app',
  directives: [ LanguagesComponent ],
  providers: [ LanguageService ],
  template: `
    <h1>{{title}}</h1>
    <ds-languages></ds-languages>
  `
})

export class AppComponent {
  title = 'diSimplicial Explorer';
}
