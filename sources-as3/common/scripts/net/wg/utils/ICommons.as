package net.wg.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.data.constants.KeyProps;
   import net.wg.infrastructure.interfaces.IUserProps;
   
   public interface ICommons
   {
       
      
      function keyToString(param1:Number) : KeyProps;
      
      function addBlankLines(param1:String, param2:TextField, param3:Vector.<TextField>) : void;
      
      function setSaturation(param1:Sprite, param2:Number) : void;
      
      function setGlowFilter(param1:DisplayObject, param2:Number) : void;
      
      function setShadowFilter(param1:DisplayObject, param2:uint) : void;
      
      function setShadowFilterWithParams(param1:DisplayObject, param2:Number = 4.0, param3:Number = 45, param4:uint = 0, param5:Number = 1.0, param6:Number = 4.0, param7:Number = 4.0, param8:Number = 1.0, param9:int = 1, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false) : void;
      
      function setBlur(param1:DisplayObject, param2:Number = 4.0, param3:Number = 4.0, param4:int = 1) : void;
      
      function setColorTransformMultipliers(param1:DisplayObject, param2:Number = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1) : void;
      
      function releaseReferences(param1:Object, param2:Boolean = true) : void;
      
      function cutBitmapFromBitmapData(param1:BitmapData, param2:Rectangle) : Bitmap;
      
      function getUserProps(param1:String, param2:String = null, param3:String = null, param4:int = 0, param5:Array = null, param6:String = "") : IUserProps;
      
      function formatPlayerName(param1:TextField, param2:IUserProps, param3:Boolean = false, param4:Boolean = false, param5:String = "..") : Boolean;
      
      function truncateTextFieldText(param1:TextField, param2:String, param3:Boolean = true, param4:Boolean = false, param5:String = "..", param6:uint = 4) : String;
      
      function truncateTextFieldMultiline(param1:TextField, param2:String, param3:uint, param4:String = "..") : Boolean;
      
      function truncateHtmlTextMultiline(param1:TextField, param2:String, param3:uint = 1, param4:String = "..") : Boolean;
      
      function cutHtmlText(param1:String) : String;
      
      function getFullPlayerName(param1:IUserProps, param2:Boolean = false) : String;
      
      function addMultipleHandlers(param1:Vector.<IEventDispatcher>, param2:String, param3:Function) : void;
      
      function removeMultipleHandlers(param1:Vector.<IEventDispatcher>, param2:String, param3:Function) : void;
      
      function initTabIndex(param1:Vector.<InteractiveObject>) : void;
      
      function moveDsiplObjToEndOfText(param1:DisplayObject, param2:TextField, param3:int = 0, param4:int = 0) : void;
      
      function rgbToArgb(param1:uint, param2:Number) : uint;
      
      function updateTextFieldSize(param1:TextField, param2:Boolean = true, param3:Boolean = true) : void;
      
      function updateChildrenMouseEnabled(param1:DisplayObjectContainer, param2:Boolean) : void;
      
      function updateChildrenMouseBehavior(param1:DisplayObjectContainer, param2:Boolean, param3:Boolean, param4:Vector.<DisplayObject> = null) : void;
      
      function flipHorizontal(param1:DisplayObject) : void;
      
      function isLeftButton(param1:MouseEvent) : Boolean;
      
      function isRightButton(param1:MouseEvent) : Boolean;
      
      function addEmptyHitArea(param1:Sprite) : void;
      
      function formatNumberToStringWithSpaces(param1:int) : String;
   }
}
