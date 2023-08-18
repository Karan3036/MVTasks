import { LightningElement, track } from 'lwc';

export default class PageNotFound extends LightningElement {
  @track imageUrl = 'https://blog.mozilla.org/wp-content/blogs.dir/278/files/2018/05/No_More_404s.gif';
  @track errorMessage = 'Sorry, the page you are looking for cannot be found.';
  
}