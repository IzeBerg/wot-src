package net.wg.gui.interfaces
{
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   import scaleform.clik.utils.Padding;
   
   public interface ISoundButtonEx extends ISoundButton, IHelpLayoutComponent
   {
       
      
      function set inspectableDisabledFillPadding(param1:Object) : void;
      
      function get disabledFillPadding() : Padding;
      
      function set disabledFillPadding(param1:Padding) : void;
      
      function get helpDirection() : String;
      
      function set helpDirection(param1:String) : void;
      
      function get helpText() : String;
      
      function set helpText(param1:String) : void;
      
      function get paddingHorizontal() : Number;
      
      function set paddingHorizontal(param1:Number) : void;
      
      function get tooltip() : String;
      
      function set tooltip(param1:String) : void;
      
      function get minWidth() : Number;
      
      function set minWidth(param1:Number) : void;
      
      function get dynamicSizeByText() : Boolean;
      
      function set dynamicSizeByText(param1:Boolean) : void;
      
      function get changeSizeOnlyUpwards() : Boolean;
      
      function set changeSizeOnlyUpwards(param1:Boolean) : void;
      
      function get useHtmlText() : Boolean;
      
      function set useHtmlText(param1:Boolean) : void;
      
      function get usePreventUpdateTextScale() : Boolean;
      
      function set usePreventUpdateTextScale(param1:Boolean) : void;
   }
}
