package transitions;

import javax.xml.bind.annotation.XmlRootElement;

import sqlSchema.Attribute;
import sqlSchema.Table;

/**
 * @author iskoulis
 *
 */
@XmlRootElement
public class Update extends Transition{

	public Update() {
		super();
	}
	
	public void updateAttribute(Attribute newAttribute, String type) throws Exception {
		super.attribute(newAttribute);
		this.type = type;
	}
	
	public void updateTable(Table newTable, String type) {
		super.table(newTable);
		this.type = type;
	}
}
