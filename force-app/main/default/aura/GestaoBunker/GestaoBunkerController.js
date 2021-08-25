({
    init : function(component, event, helper) {
        console.log('>>> INIT <<<');
		helper.carregaBunkers(component, event);
        helper.setColumns(component);
	},

    handleChange: function (component, event, helper) {
        helper.carregaMembros(component, event);
    },
    handleChangeHumanos: function (component, event, helper) {
        helper.recuperaHumanoSelecionado(component, event);
    },
    
    incluirHumano: function (component, event, helper) {
        helper.incluirHumano(component, event);
    },

    viewRecord : function(component, event, helper) {
        helper.viewRecord( component, event );
	},

    showModal : function(component, event, helper) {
        component.set("v.showModal",true);
        helper.carregaHumanos( component, event );
	},
    
    closeModal : function(component, event, helper) {
        component.set("v.showModal",false);
	}

})