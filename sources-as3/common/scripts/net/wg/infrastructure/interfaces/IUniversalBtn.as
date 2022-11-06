package net.wg.infrastructure.interfaces
{
   import flash.filters.DropShadowFilter;
   import flash.utils.Dictionary;
   import net.wg.utils.IUniversalBtnStyledDisplayObjects;
   
   public interface IUniversalBtn extends IUIComponentEx
   {
       
      
      function setStyle(param1:String, param2:IUniversalBtnStyledDisplayObjects, param3:uint, param4:uint, param5:Dictionary, param6:String, param7:DropShadowFilter) : void;
      
      function get styleID() : String;
      
      function get styledDisplayObjects() : IUniversalBtnStyledDisplayObjects;
      
      function switchAlertIndicatorVisible(param1:Boolean) : void;
   }
}
