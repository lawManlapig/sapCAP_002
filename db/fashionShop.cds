namespace app.fashionShop;

using {Currency} from '@sap/cds/common';

//Entity
entity Sections {
    key id          : UUID @(title: 'Section ID');
        name        : String(16);
        description : String(64);
// Fashion_Types : Association to many Fashion_Types
//                     on Fashion_Types.section = $self;
}

entity Fashion_Types {
    key id          : UUID;
    key section     : Association to Sections @(title: 'Section ID');
        typename    : String(16) @(title: 'Fashion Type');
        description : String(64);
}

entity Fashion_Items {
    key id          : UUID;
    key fashionType : Association to Fashion_Types @(title: 'Fashion Type');
        itemname    : String(16) @(title: 'Item Name');
        brand       : String(16);
        size        : String(8);
        material    : String(16);
        price       : String(10);
        currency    : Currency;
        isAvailable : String(1);
}

//CDS Views
//paakyat yung select/navigation niya
view YC_FashionShop as
    // select from Sections
    // left outer join Fashion_Types
    //     on Sections.id = Fashion_Types.id
    // left outer join Fashion_Items
    //     on Fashion_Types.id = Fashion_Items.fashionType
    // {
    //     Sections.id as sectionID
    // }
    // where
    //     Fashion_Items.isAvailable = 'X';
select from Fashion_Items as fItem {
        fItem.fashionType.section.id          as sectionID,
        fItem.fashionType.section.name        as sectionName,
        fItem.fashionType.section.description as sectionDescription,
        fItem.fashionType.id                  as fashionTypeID,
        fItem.fashionType.typename            as fashionTypeTypename,
        fItem.fashionType.description         as fashionTypeDescription,
    key fItem.id                              as fashionItemID,
        fItem.itemname                        as fashionItemItemname,
        fItem.brand                           as fashionItemBrand,
        fItem.size                            as fashionItemSize,
        fItem.material                        as fashionItemMaterial,
        fItem.price                           as fashionItemPrice,
        fItem.currency                        as fashionItemCurrency,
        // fItem.isAvailable                     as fastionItemAvailable,
        //Concatenate
        concat(
            fItem.brand, concat(
                ' : ', fItem.itemname
            )
        )                                     as itemDetails : String(32),
        //Case
        case
            when
                fItem.price >= 500
            then
                'Premium fashion item'
            when
                fItem.price     >= 100
                and fItem.price <  500
            then
                'Mid-Range fashion item'
            else
                'Low-Range fashion item'
        end                                   as priceRange  : String(20)
}
//Where Condition
where
    fItem.isAvailable = 'X';
