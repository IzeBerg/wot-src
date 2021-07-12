package net.wg.gui.battle.views.messages
{
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IMessage extends IDisposable, IEventDispatcher
   {
       
      
      function show() : void;
      
      function close() : void;
      
      function getDisplayObjects() : Vector.<DisplayObject>;
      
      function get key() : String;
      
      function get width() : Number;
      
      function get height() : Number;
      
      function get x() : Number;
      
      function set x(param1:Number) : void;
      
      function get y() : Number;
      
      function set y(param1:Number) : void;
      
      function deleteFromPool() : void;
   }
}
