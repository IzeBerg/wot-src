package net.wg.gui.components.controls.interfaces
{
   import net.wg.gui.components.controls.listselection.AbstractListSelectionNavigator;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.utils.Padding;
   
   public interface ISortableTable extends IUIComponentEx, IFocusChainContainer, IFocusContainer
   {
       
      
      function sortByField(param1:String, param2:String) : void;
      
      function resetListSelectedItem() : void;
      
      function setSelectedField(param1:String, param2:String) : void;
      
      function get listSelectedIndex() : int;
      
      function set listSelectedIndex(param1:int) : void;
      
      function get headerDP() : IDataProvider;
      
      function set headerDP(param1:IDataProvider) : void;
      
      function get listVisible() : Boolean;
      
      function set listVisible(param1:Boolean) : void;
      
      function get listDP() : IDataProvider;
      
      function set listDP(param1:IDataProvider) : void;
      
      function get isListSelectable() : Boolean;
      
      function set isListSelectable(param1:Boolean) : void;
      
      function get isListMouseEnabled() : Boolean;
      
      function set isListMouseEnabled(param1:Boolean) : void;
      
      function set scrollbarPadding(param1:Object) : void;
      
      function set listPadding(param1:Padding) : void;
      
      function get rowHeight() : Number;
      
      function set rowHeight(param1:Number) : void;
      
      function get rowHeightFixed() : Boolean;
      
      function set rowHeightFixed(param1:Boolean) : void;
      
      function get headerHeight() : int;
      
      function set headerHeight(param1:int) : void;
      
      function get rowWidthAutoResize() : Boolean;
      
      function set rowWidthAutoResize(param1:Boolean) : void;
      
      function get listLinkage() : String;
      
      function set listLinkage(param1:String) : void;
      
      function get rendererLinkage() : String;
      
      function set rendererLinkage(param1:String) : void;
      
      function get isSortable() : Boolean;
      
      function set isSortable(param1:Boolean) : void;
      
      function get useRightBtn() : Boolean;
      
      function set useRightBtn(param1:Boolean) : void;
      
      function get useSmartScrollbar() : Boolean;
      
      function set useSmartScrollbar(param1:Boolean) : void;
      
      function get listSelectNavigator() : AbstractListSelectionNavigator;
      
      function set listSelectNavigator(param1:AbstractListSelectionNavigator) : void;
      
      function get isRendererToggle() : Boolean;
      
      function set isRendererToggle(param1:Boolean) : void;
      
      function get headerSelectedIndex() : int;
      
      function set headerSelectedIndex(param1:int) : void;
      
      function get scrollPosition() : Number;
   }
}
