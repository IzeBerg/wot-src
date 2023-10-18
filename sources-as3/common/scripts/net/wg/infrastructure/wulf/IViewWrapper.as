package net.wg.infrastructure.wulf
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.ITutorialView;
   
   public interface IViewWrapper extends ITutorialView
   {
       
      
      function setTexture(param1:BitmapData) : void;
      
      function caretPosChanged(param1:Number, param2:Number) : void;
      
      function inputStarted(param1:Number, param2:Number, param3:Number, param4:Number) : void;
      
      function inputEnded() : void;
      
      function freezeUntilResize() : void;
      
      function setSize(param1:uint, param2:uint) : void;
      
      function setScale(param1:Number) : void;
      
      function setHitAreaPaddings(param1:int, param2:int, param3:int, param4:int) : void;
      
      function setCursor(param1:String) : void;
      
      function updateParentSize(param1:Number, param2:Number) : void;
      
      function setContainerWrapper(param1:IBaseContainerWrapper) : void;
      
      function getContainerWrapper() : IBaseContainerWrapper;
      
      function getTutorialHintZone(param1:String) : DisplayObject;
      
      function removeTutorialHintZone(param1:String) : void;
      
      function show(param1:Boolean) : void;
      
      function hide(param1:Boolean) : void;
      
      function hitTest(param1:int, param2:int) : Boolean;
      
      function onShown() : void;
      
      function onHidden() : void;
      
      function get hitRect() : Rectangle;
      
      function get focused() : Boolean;
      
      function get drawDebug() : Boolean;
      
      function set drawDebug(param1:Boolean) : void;
   }
}
