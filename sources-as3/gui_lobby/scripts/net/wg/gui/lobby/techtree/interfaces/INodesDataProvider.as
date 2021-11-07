package net.wg.gui.lobby.techtree.interfaces
{
   import flash.events.IEventDispatcher;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface INodesDataProvider extends IEventDispatcher, IDisposable
   {
       
      
      function cleanUp() : void;
      
      function invalidate(param1:String, param2:Object) : void;
      
      function parse(param1:Object) : void;
      
      function getRootItem() : NodeData;
      
      function getItemAt(param1:Number) : NodeData;
      
      function getIndexByID(param1:Number) : Number;
      
      function getItemByID(param1:Number) : NodeData;
      
      function setEarnedXP(param1:Number, param2:Number) : Boolean;
      
      function setState(param1:Number, param2:Number, param3:Number) : Boolean;
      
      function setUnlockProps(param1:Number, param2:UnlockProps) : Boolean;
      
      function setItemField(param1:String, param2:Number, param3:Object) : Boolean;
      
      function get nation() : String;
      
      function get length() : Number;
      
      function isPremiumItem(param1:Number) : Boolean;
   }
}
