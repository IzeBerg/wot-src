package net.wg.gui.battle.battleRoyale.views.components.respawnMessages
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.battleRoyale.data.RespawnMessageVO;
   import net.wg.infrastructure.base.meta.IBRRespawnMessagePanelMeta;
   import net.wg.infrastructure.base.meta.impl.BRRespawnMessagePanelMeta;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   
   public class RespawnMessagePanel extends BRRespawnMessagePanelMeta implements IBRRespawnMessagePanelMeta, IStageSizeDependComponent
   {
      
      private static const SMALL_SUFFIX:String = "Small";
       
      
      private var _currentMessage:BaseRespawnMessage = null;
      
      private var _isSmallRendererSize:Boolean = false;
      
      public function RespawnMessagePanel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         App.stageSizeMgr.unregister(this);
         this.clearMessage(this._currentMessage);
         this._currentMessage = null;
         super.onDispose();
      }
      
      override protected function addMessage(param1:RespawnMessageVO) : void
      {
         this.clearMessage(this._currentMessage);
         this._currentMessage = this.createMessage(param1,true,false);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stageSizeMgr.register(this);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.recreateCurrentMessage();
         }
      }
      
      public function as_hideMessage() : void
      {
         if(this._currentMessage)
         {
            this._currentMessage.hide();
         }
      }
      
      public function as_setMessageTime(param1:int) : void
      {
         var _loc2_:RespawnMessageVO = null;
         if(this._currentMessage)
         {
            _loc2_ = this._currentMessage.data;
            _loc2_.time = param1;
            this._currentMessage.setData(_loc2_,false);
         }
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = param1 <= StageSizeBoundaries.WIDTH_1366 || param2 == StageSizeBoundaries.HEIGHT_768;
         if(this._isSmallRendererSize != _loc3_)
         {
            this._isSmallRendererSize = _loc3_;
            invalidateSize();
         }
      }
      
      private function recreateCurrentMessage() : void
      {
         var _loc1_:RespawnMessageVO = null;
         var _loc2_:BaseRespawnMessage = null;
         if(this._currentMessage)
         {
            _loc1_ = this._currentMessage.data;
            if(_loc1_)
            {
               _loc1_.time = this._currentMessage.currentTime;
               this.clearMessage(this._currentMessage);
               _loc2_ = this.createMessage(_loc1_,false);
               this._currentMessage = _loc2_;
            }
         }
      }
      
      private function createMessage(param1:RespawnMessageVO, param2:Boolean, param3:Boolean = false) : BaseRespawnMessage
      {
         var _loc4_:String = !!this._isSmallRendererSize ? param1.messageLinkage + SMALL_SUFFIX : param1.messageLinkage;
         var _loc5_:BaseRespawnMessage = App.utils.classFactory.getComponent(_loc4_,BaseRespawnMessage);
         _loc5_.setData(param1,param3);
         _loc5_.show(param2);
         _loc5_.addEventListener(Event.DEACTIVATE,this.onMessageDeactivateHandler,false,0,true);
         _loc5_.x = _loc5_.width >> 1;
         _loc5_.y = _loc5_.height >> 1;
         addChild(_loc5_ as DisplayObject);
         return _loc5_;
      }
      
      private function clearMessage(param1:BaseRespawnMessage) : void
      {
         if(param1 && !param1.isDisposed())
         {
            param1.removeEventListener(Event.DEACTIVATE,this.onMessageDeactivateHandler);
            removeChild(param1);
            param1.dispose();
         }
      }
      
      private function onMessageDeactivateHandler(param1:Event) : void
      {
         this.clearMessage(param1.target as BaseRespawnMessage);
      }
   }
}
