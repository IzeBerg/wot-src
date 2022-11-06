package net.wg.infrastructure.interfaces
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public interface IContextMenu
   {
       
      
      function build(param1:Vector.<IContextItem>, param2:Point) : void;
      
      function setMemberItemData(param1:Object) : void;
      
      function get clickPoint() : Point;
      
      function set onItemSelectCallback(param1:Function) : void;
      
      function set onReleaseOutsideCallback(param1:Function) : void;
      
      function get parentObj() : DisplayObject;
      
      function set parentObj(param1:DisplayObject) : void;
   }
}
