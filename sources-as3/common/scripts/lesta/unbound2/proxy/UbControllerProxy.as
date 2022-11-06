package lesta.unbound2.proxy
{
   import flash.display.DisplayObject;
   import lesta.unbound2.proxy.base.UbGFxWrapperProxy;
   
   public class UbControllerProxy extends UbGFxWrapperProxy
   {
       
      
      protected var m_player:UbPlayerProxy;
      
      protected var m_targetObject:DisplayObject;
      
      protected var m_name:String;
      
      protected var m_rootData:Object;
      
      public function UbControllerProxy(param1:String)
      {
         super();
         this.m_name = param1;
      }
      
      public function setTargetObject(param1:DisplayObject) : void
      {
         this.m_targetObject = param1;
      }
      
      public function setPlayerProxy(param1:UbPlayerProxy) : void
      {
         this.m_player = param1;
      }
      
      public function setRootData(param1:Object) : void
      {
         this.m_rootData = param1;
      }
      
      public function init() : void
      {
      }
      
      public function destructorCalledByUnbound() : void
      {
         this.m_targetObject = null;
         this.m_player = null;
      }
      
      public function get player() : UbPlayerProxy
      {
         return this.m_player;
      }
      
      public function get targetObject() : DisplayObject
      {
         return this.m_targetObject;
      }
      
      public function get rootData() : Object
      {
         return this.m_rootData;
      }
   }
}
