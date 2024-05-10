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

    LineItem               : [
        {Value: fashionType.section.name},
        {Value: fashionType.typename},
        {Value: itemname},
        {Value: brand},
        {Value: size},
        {Value: price},
        {Value: currency_code}
    ],

    Facets                 : [{
        $Type : 'UI.CollectionFacet',
        Label : 'Fashion Details',
        Facets: [{
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#ItemDetails',
        }],
    }],

    FieldGroup #ItemDetails: {Data: [
        {Value: fashionType_id},
        {Value: fashionType.typename},
        {Value: itemname},
        {Value: size},
        {Value: price}
    ]},
});
