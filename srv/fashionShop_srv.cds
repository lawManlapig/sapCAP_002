using app.fashionShop from '../db/fashionShop';

//Service
service fashionShop_Service {
    entity Sections        as projection on fashionShop.Sections;
    entity Fashion_Types   as projection on fashionShop.Fashion_Types;
    entity Fashion_Items   as projection on fashionShop.Fashion_Items;
    //Service for the CDS View
    entity Srv_FashionShop as projection on fashionShop.YC_FashionShop;
}

annotate fashionShop.Fashion_Items with @(UI: {
    HeaderInfo             : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Online Fashion Shop TypeName',
        TypeNamePlural: 'Online Fashion Shop',
        Title         : {Value: itemname}, //object declaration
        Description   : {Value: 'Online Fashion Shop Description'}
    },

    //Selection Fields
    SelectionFields        : [
        //yung field ng CDS View mo
        fashionType_id,
        brand,
        itemname,
        size,
        price
    ],

    LineItem               : [
        {
            Value: fashionType.section.name,
            Label: 'Section Name'
        },
        {
            Value: fashionType.typename,
            Label: 'Fashion Type',
        },
        {Value: itemname},
        {Value: brand},
        {Value: size},
        {Value: price},
        {Value: currency_code}
    ],

    //Facets  -- parang Grouping ito...
    Facets                 : [{
        $Type : 'UI.CollectionFacet',
        ID: '1', //Grouping number.. incase you need to add more in the future
        Label : 'Fashion Details',
        Facets: [{
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#ItemDetails',
        }],
    }
    //Additional FAcet here... just remember to change the Target
    ],

    FieldGroup #ItemDetails: {Data: [
        {Value: fashionType_id},
        {Value: fashionType.typename},
        {Value: itemname},
        {Value: size},
        {Value: price}
    ]},
});
