package net.wg.gui.battle.battleRoyale.views.playerStats
{
   import fl.motion.easing.Cubic;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.battleRoyale.views.shamrock.components.results.WinnerShamrockAnimation;
   import net.wg.gui.battle.battleRoyale.views.shamrock.interfaces.IShamrockListener;
   import net.wg.infrastructure.base.meta.IBattleRoyalePlayerStatsMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyalePlayerStatsMeta;
   import scaleform.clik.motion.Tween;
   
   public class BattleRoyalePlayerStats extends BattleRoyalePlayerStatsMeta implements IBattleRoyalePlayerStatsMeta, IShamrockListener
   {
      
      private static const SHAMROCK_ANIMATION_MC:String = "BRWinnerShamrockAnimationUI";
      
      private static const FRAME_START:String = "showTotal";
      
      private static const ITEM_WIDTH:uint = 90;
      
      private static const X_GAP:uint = 65;
      
      private static const X_OFFSET:uint = ITEM_WIDTH + X_GAP;
      
      private static const FADE_IN_DELAY:uint = 150;
      
      private static const TITLE_TF_FADE_IN_DURATION:Number = 500;
      
      private static const TITLE_TF_FADE_IN_ALPHA:Number = 1;
      
      private static const VERTICAL_ALIGNMENT_PERCENT:Number = 0.2;
      
      private static const START_ANIM_DELAY:int = 500;
       
      
      public var titleTf:TextField = null;
      
      public var bg:Sprite = null;
      
      private var _shamrockAnimation:WinnerShamrockAnimation = null;
      
      private var _renderers:Vector.<BattleRoyalePlayerStatRenderer>;
      
      private var _currentTween:Tween = null;
      
      private var _stageHeight:int = 0;
      
      private var _timer:int = -1;
      
      public function BattleRoyalePlayerStats()
      {
         this._renderers = new Vector.<BattleRoyalePlayerStatRenderer>();
         super();
         this.titleTf.blendMode = BlendMode.SCREEN;
      }
      
      override public function setCompVisible(param1:Boolean) : void
      {
         super.setCompVisible(param1);
         if(param1)
         {
            if(!this._shamrockAnimation)
            {
               this._shamrockAnimation = App.instance.utils.classFactory.getComponent(SHAMROCK_ANIMATION_MC,WinnerShamrockAnimation);
               addChild(this._shamrockAnimation);
               invalidateSize();
            }
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._shamrockAnimation && isInvalid(InvalidationType.SIZE))
         {
            this._shamrockAnimation.x = 0;
            this._shamrockAnimation.y = this._stageHeight * VERTICAL_ALIGNMENT_PERCENT >> 0;
         }
      }
      
      override protected function setData(param1:Vector.<BattleRoyalePlayerStatVO>) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:BattleRoyalePlayerStatVO = null;
         var _loc2_:uint = param1.length;
         if(_loc2_ == 0)
         {
            this.titleTf.visible = false;
            this.setCompVisible(false);
            return;
         }
         this.setCompVisible(true);
         if(this.titleTf.visible)
         {
            this.clearTween();
            this.titleTf.alpha = 0;
            this._currentTween = new Tween(TITLE_TF_FADE_IN_DURATION,this.titleTf,{"alpha":TITLE_TF_FADE_IN_ALPHA},{"ease":Cubic.easeOut});
         }
         var _loc3_:BattleRoyalePlayerStatRenderer = null;
         var _loc4_:int = _loc2_ - this._renderers.length;
         while(_loc4_ > 0)
         {
            _loc3_ = App.utils.classFactory.getComponent(Linkages.BATTLE_ROYALE_PLAYER_STAT_RENDERER,BattleRoyalePlayerStatRenderer);
            this._renderers.push(_loc3_);
            addChild(_loc3_);
            _loc4_--;
         }
         for each(_loc3_ in this._renderers)
         {
            _loc3_.visible = false;
         }
         _loc5_ = this._renderers.length;
         _loc6_ = ITEM_WIDTH * _loc5_ + X_GAP * (_loc5_ - 1);
         _loc7_ = -_loc6_ >> 1;
         _loc8_ = 0;
         _loc9_ = 0;
         for each(_loc10_ in param1)
         {
            _loc3_ = this._renderers[_loc9_];
            _loc3_.x = _loc7_;
            _loc3_.visible = true;
            _loc3_.setData(_loc10_.description,_loc10_.imageID,_loc10_.value);
            _loc3_.fadeIn(_loc8_);
            _loc7_ += X_OFFSET;
            _loc8_ += FADE_IN_DELAY;
            _loc9_++;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BattleRoyalePlayerStatRenderer = null;
         if(this._timer != Values.DEFAULT_INT)
         {
            clearTimeout(this._timer);
         }
         this.bg = null;
         if(this._shamrockAnimation)
         {
            this._shamrockAnimation.stop();
            this._shamrockAnimation = null;
         }
         for each(_loc1_ in this._renderers)
         {
            _loc1_.dispose();
         }
         this._renderers.length = 0;
         this._renderers = null;
         this.titleTf = null;
         this.clearTween();
         super.onDispose();
      }
      
      public function addShamrocks(param1:int, param2:int, param3:Boolean) : void
      {
      }
      
      public function as_setInitData(param1:String) : void
      {
         this.titleTf.text = param1;
         this.titleTf.visible = true;
      }
      
      public function as_setStpCoins(param1:int, param2:int) : void
      {
         if(this._timer != Values.DEFAULT_INT)
         {
            clearTimeout(this._timer);
         }
         this._timer = setTimeout(this.startAnimation,START_ANIM_DELAY);
         this._shamrockAnimation.setValues(param1,param2,0);
      }
      
      public function collected(param1:int, param2:int, param3:Boolean) : void
      {
      }
      
      public function setShamrocks(param1:int) : void
      {
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageHeight = param2;
         invalidateSize();
      }
      
      private function startAnimation() : void
      {
         gotoAndPlay(FRAME_START);
      }
      
      private function clearTween() : void
      {
         if(this._currentTween)
         {
            this._currentTween.paused = true;
            this._currentTween.dispose();
            this._currentTween = null;
         }
      }
   }
}
