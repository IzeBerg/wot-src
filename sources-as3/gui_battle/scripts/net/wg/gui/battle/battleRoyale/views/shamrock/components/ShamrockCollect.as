package net.wg.gui.battle.battleRoyale.views.shamrock.components
{
   import flash.display.FrameLabel;
   import net.wg.gui.battle.battleRoyale.views.shamrock.data.ShamrockTransactionVO;
   import net.wg.gui.battle.battleRoyale.views.shamrock.events.ShamrockAnimationEvent;
   import net.wg.gui.battle.battleRoyale.views.shamrock.interfaces.IShamrockListener;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   
   public class ShamrockCollect extends BattleUIComponent implements IDAAPIModule, IDisplayableComponent, IShamrockListener
   {
      
      private static const FRAME_COLLECT:String = "collect";
      
      private static const FRAME_HIDE:String = "hide";
      
      private static const FRAME_COMPLETE:String = "complete";
       
      
      public var animation:ShamrockCollectAnimation = null;
      
      private var _isDAAPIInited:Boolean = false;
      
      private var _completedScriptFrame:int = 0;
      
      private var _hideScriptFrame:int = 0;
      
      private var _transactionsPending:Vector.<ShamrockTransactionVO>;
      
      private var _curTransaction:ShamrockTransactionVO = null;
      
      private var _isCompVisible:Boolean = true;
      
      public function ShamrockCollect()
      {
         this._transactionsPending = new Vector.<ShamrockTransactionVO>();
         super();
      }
      
      override protected function onDispose() : void
      {
         this.stopAnimation();
         addFrameScript(this._completedScriptFrame,null);
         this.animation.dispose();
         this.animation = null;
         this._transactionsPending.length = 0;
         this._transactionsPending = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         var _loc3_:FrameLabel = null;
         super.configUI();
         var _loc1_:Array = this.currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_.name == FRAME_HIDE)
            {
               this._hideScriptFrame = _loc3_.frame;
            }
            else if(_loc3_.name == FRAME_COMPLETE)
            {
               this._completedScriptFrame = _loc3_.frame;
               addFrameScript(this._completedScriptFrame,this.onAnimationComplete);
            }
            _loc4_++;
         }
         this.stopAnimation();
      }
      
      public function addShamrocks(param1:int, param2:int, param3:Boolean) : void
      {
         this._transactionsPending.push(new ShamrockTransactionVO(param1,param2,param3));
         if(!param3)
         {
            if(!this.isRunning)
            {
               this.makeNextTransaction();
            }
         }
         else
         {
            this.makeNextTransaction();
         }
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
      }
      
      public function finishCollection() : void
      {
         this.stopAnimation();
         this.onAnimationComplete();
      }
      
      public function isCompVisible() : Boolean
      {
         return this._isCompVisible;
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
         this._isCompVisible = visible = param1;
      }
      
      public function setShamrocks(param1:int) : void
      {
         gotoAndStop(FRAME_HIDE);
      }
      
      public function stopAnimation() : void
      {
         gotoAndStop(FRAME_HIDE);
      }
      
      private function makeNextTransaction() : void
      {
         if(this._transactionsPending.length > 0)
         {
            this._curTransaction = this._transactionsPending.shift();
            this.makeTransaction(this._curTransaction);
         }
         else
         {
            this._curTransaction = null;
         }
      }
      
      private function makeTransaction(param1:ShamrockTransactionVO) : void
      {
         if(visible && !param1.fromTeammate)
         {
            this.animation.setValue(param1.amount);
            gotoAndPlay(FRAME_COLLECT);
         }
         else
         {
            this.finishCollection();
         }
      }
      
      private function onAnimationComplete() : void
      {
         if(this._curTransaction)
         {
            dispatchEvent(new ShamrockAnimationEvent(ShamrockAnimationEvent.COLLECTED,this._curTransaction.amount,this._curTransaction.newTotal,this._curTransaction.fromTeammate));
         }
         this.makeNextTransaction();
      }
      
      public function get isDAAPIInited() : Boolean
      {
         return this._isDAAPIInited;
      }
      
      private function get isRunning() : Boolean
      {
         return currentFrame > this._hideScriptFrame && currentFrame < this._completedScriptFrame;
      }
   }
}
