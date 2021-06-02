import BasePage, { BasePageProperties } from "../BasePage/BasePage";

class ContactPageProperies extends BasePageProperties {
  title?: string = "";
  phone: string = "";
  address: string = "";
}

export default class ContactPage extends BasePage<ContactPageProperies> {
  renderMain() {
    return (
      <div>
        <h1>{this.props.title ?? "Contact us"}</h1>
        <p>
          We are located at: <br />
          Begrtadksa ulica 83
        </p>
        <p>Phone: +381612345678</p>
      </div>
    );
  }
}
