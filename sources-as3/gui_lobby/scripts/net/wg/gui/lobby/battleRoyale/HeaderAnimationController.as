package net.wg.gui.lobby.battleRoyale
{
   import com.gskinner.motion.GTweener;
   import com.gskinner.motion.easing.Cubic;
   import flash.events.EventDispatcher;
   import net.wg.gui.lobby.battleRoyale.widget.data.BattleRoyaleHangarWidget;
   import net.wg.gui.lobby.hangar.HangarHeader;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HeaderAnimationController extends EventDispatcher implements IDisposable
   {
      
      private static const BATTLE_TYPE_SELECTOR_Y:int = 16;
      
      private static const HEADER_ORIGINAL_Y:int = 33;
      
      private static const HEADER_Y:int = 103;
      
      private static const BATTLE_TYPE_SELECTOR_Y_HIDDEN:Number = -54;
      
      private static const MOVE_DOWN_DURATION:Number = 1.1;
      
      private static const START_DELAY:int = 1;
       
      
      private var _header:HangarHeader = null;
      
      private var _battleTypeSelector:BattleTypeSelector = null;
      
      private var _isDisposed:Boolean = false;
      
      public function HeaderAnimationController(param1:HangarHeader, param2:BattleTypeSelector)
      {
         super();
         this._header = param1;
         this._battleTypeSelector = param2;
         this._battleTypeSelector.y = BATTLE_TYPE_SELECTOR_Y_HIDDEN;
      }
      
      public function dispose() : void
      {
         if(!this.isDisposed())
         {
            GTweener.removeTweens(this._header);
            GTweener.removeTweens(this._battleTypeSelector);
            this._header.y = HEADER_ORIGINAL_Y;
            this._header = null;
            this._battleTypeSelector = null;
            this._isDisposed = true;
         }
      }
      
      public function hide() : void
      {
         this._header.y = HEADER_ORIGINAL_Y;
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function playShowAnimation(param1:Boolean) : void
      {
         var _loc2_:BattleRoyaleHangarWidget = null;
         _loc2_ = this._header.widget as BattleRoyaleHangarWidget;
         if(_loc2_ && _loc2_.hasAlert())
         {
            this._header.y = HEADER_ORIGINAL_Y;
            this._battleTypeSelector.y = BATTLE_TYPE_SELECTOR_Y_HIDDEN;
            return;
         }
         if(param1)
         {
            this._battleTypeSelector.y = BATTLE_TYPE_SELECTOR_Y;
            this._header.y = HEADER_Y;
            this._battleTypeSelector.startIdleAnimationS();
         }
         else
         {
            this._header.y = HEADER_ORIGINAL_Y;
            this._battleTypeSelector.alpha = 0;
            this._battleTypeSelector.y = BATTLE_TYPE_SELECTOR_Y_HIDDEN;
            if(_loc2_)
            {
               _loc2_.startWidgetBlinkAnimation();
            }
            GTweener.to(this._header,MOVE_DOWN_DURATION,{"y":HEADER_Y},{
               "ease":Cubic.easeOut,
               "delay":START_DELAY
            });
            GTweener.to(this._battleTypeSelector,MOVE_DOWN_DURATION,{
               "alpha":1,
               "y":BATTLE_TYPE_SELECTOR_Y
            },{
               "ease":Cubic.easeOut,
               "delay":START_DELAY,
               "onComplete":this.onAnimationComplete
            });
         }
      }
      
      private function onAnimationComplete() : void
      {
         this._battleTypeSelector.startFirstShowAnimationS();
      }
   }
}
