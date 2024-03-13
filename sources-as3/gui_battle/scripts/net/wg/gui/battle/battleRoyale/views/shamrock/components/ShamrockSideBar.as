package net.wg.gui.battle.battleRoyale.views.shamrock.components
{
   import flash.events.Event;
   import net.wg.gui.battle.battleRoyale.views.shamrock.data.ShamrockTransactionVO;
   import net.wg.gui.battle.battleRoyale.views.shamrock.events.ShamrockAnimationEvent;
   import net.wg.gui.battle.battleRoyale.views.shamrock.interfaces.IShamrockListener;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   
   public class ShamrockSideBar extends BattleUIComponent implements IDAAPIModule, IDisplayableComponent, IShamrockListener
   {
      
      private static const FRAME_NORMAL:String = "normal";
      
      private static const FRAME_ADD:String = "add";
      
      private static const FRAME_ADD_TEAMMATE:String = "addFromTeammate";
      
      private static const RIGHT_OFFSET:int = 6;
       
      
      public var totalAmount:ShamrockTotalAmount = null;
      
      public var receiveAnimation:ShamrockReceiveAnimation = null;
      
      private var _isDAAPIInited:Boolean = false;
      
      private var _transactionsPending:Vector.<ShamrockTransactionVO>;
      
      public function ShamrockSideBar()
      {
         this._transactionsPending = new Vector.<ShamrockTransactionVO>();
         super();
         this.setShamrocks(0);
         this.receiveAnimation.addEventListener(ShamrockAnimationEvent.VALUE_ADDED,this.onReceiveAnimationValueAddedHandler);
         this.receiveAnimation.addEventListener(ShamrockAnimationEvent.COMPLETED,this.onReceiveAnimationCompletedHandler);
      }
      
      override protected function onDispose() : void
      {
         this.receiveAnimation.removeEventListener(ShamrockAnimationEvent.VALUE_ADDED,this.onReceiveAnimationValueAddedHandler);
         this.receiveAnimation.dispose();
         this.receiveAnimation = null;
         this.totalAmount.dispose();
         this.totalAmount = null;
         this._transactionsPending.length = 0;
         this._transactionsPending = null;
         super.onDispose();
      }
      
      public function addShamrocks(param1:int, param2:int, param3:Boolean) : void
      {
      }
      
      public final function as_dispose() : void
      {
         dispose();
      }
      
      public final function as_populate() : void
      {
         this._isDAAPIInited = true;
      }
      
      public function collected(param1:int, param2:int, param3:Boolean) : void
      {
         this._transactionsPending.push(new ShamrockTransactionVO(param1,param2,param3));
         if(!this.receiveAnimation.isRunning)
         {
            this.makeNextTransaction();
         }
      }
      
      public function getRightOffset() : int
      {
         return this.totalAmount.getRightOffset() + RIGHT_OFFSET;
      }
      
      public function isCompVisible() : Boolean
      {
         return visible;
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
         visible = param1;
      }
      
      public function setShamrocks(param1:int) : void
      {
         this.totalAmount.setValue(param1);
         this.totalAmount.validateNow();
         this.receiveAnimation.clear();
         this._transactionsPending.length = 0;
         gotoAndStop(FRAME_NORMAL);
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function makeNextTransaction() : void
      {
         var _loc1_:ShamrockTransactionVO = null;
         if(this._transactionsPending.length > 0)
         {
            _loc1_ = this._transactionsPending.shift();
            this.makeTransaction(_loc1_);
         }
      }
      
      private function makeTransaction(param1:ShamrockTransactionVO) : void
      {
         this.receiveAnimation.setValue(param1.amount,param1.newTotal,param1.fromTeammate);
      }
      
      override public function get width() : Number
      {
         return this.totalAmount.width;
      }
      
      public function get isDAAPIInited() : Boolean
      {
         return this._isDAAPIInited;
      }
      
      private function onReceiveAnimationValueAddedHandler(param1:ShamrockAnimationEvent) : void
      {
         gotoAndPlay(!!param1.isFromTeamMate ? FRAME_ADD_TEAMMATE : FRAME_ADD);
         this.totalAmount.setValue(param1.totalValue);
         this.totalAmount.validateNow();
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function onReceiveAnimationCompletedHandler(param1:ShamrockAnimationEvent) : void
      {
         this.makeNextTransaction();
      }
   }
}
