package net.wg.gui.lobby.rankedBattles19.components.widget
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.rankedBattles19.data.RankShieldAnimHelperVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankShieldVO;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class RankShield extends UIComponentEx
   {
      
      private static const INVALID_ANIMATION:String = "invalidAnimation";
      
      public static const SHIELD_OFFSETS:Object = {};
      
      {
         SHIELD_OFFSETS[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = 12;
         SHIELD_OFFSETS[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = 22;
         SHIELD_OFFSETS[RANKEDBATTLES_ALIASES.WIDGET_BIG] = 30;
         SHIELD_OFFSETS[RANKEDBATTLES_ALIASES.WIDGET_HUGE] = 48;
      }
      
      public var counter:MovieClip = null;
      
      public var plate:MovieClip = null;
      
      public var shield:MovieClip = null;
      
      public var shield2:MovieClip = null;
      
      public var top:MovieClip = null;
      
      public var left:MovieClip = null;
      
      public var bottom:MovieClip = null;
      
      public var right:MovieClip = null;
      
      private var _shieldImg2:Image = null;
      
      private var _plateImg:Image = null;
      
      private var _shieldImg:Image = null;
      
      private var _topImg:Image = null;
      
      private var _leftImg:Image = null;
      
      private var _bottomImg:Image = null;
      
      private var _rightImg:Image = null;
      
      private var _labelTF:TextField = null;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _shieldData:RankShieldVO = null;
      
      private var _shieldState:String = "";
      
      private var _size:String = "";
      
      private var _isHuge:Boolean = false;
      
      private var _animateStateCallback:Function = null;
      
      private var _animateFinished:Boolean = false;
      
      private var _counterChangeCallback:Function = null;
      
      public function RankShield()
      {
         super();
         this._frameHelper = new FrameHelper(this);
      }
      
      override protected function onDispose() : void
      {
         stop();
         if(this._frameHelper)
         {
            addFrameScript(this._frameHelper.getFrameByLabel(RANKEDBATTLES_ALIASES.SHIELD_LOSE_STEP_COUNTER),null);
            addFrameScript(this._frameHelper.getFrameBeforeLabel(RANKEDBATTLES_ALIASES.SHIELD_LOSE_END),null);
            addFrameScript(this._frameHelper.getFrameBeforeLabel(RANKEDBATTLES_ALIASES.SHIELD_LOSE_STEP_END),null);
            addFrameScript(this._frameHelper.getFrameBeforeLabel(RANKEDBATTLES_ALIASES.SHIELD_RENEW_END),null);
            addFrameScript(this._frameHelper.getFrameByLabel(RANKEDBATTLES_ALIASES.SHIELD_RENEW_COUNTER),null);
            addFrameScript(this._frameHelper.getFrameBeforeLabel(RANKEDBATTLES_ALIASES.SHIELD_FULL_RENEW_END),null);
            addFrameScript(this._frameHelper.getFrameBeforeLabel(RANKEDBATTLES_ALIASES.SHIELD_FULL_RENEW_COUNTER),null);
            addFrameScript(this._frameHelper.getFrameBeforeLabel(RANKEDBATTLES_ALIASES.SHIELD_LOSE_COUNTER),null);
            this._frameHelper.dispose();
            this._frameHelper = null;
         }
         this._animateStateCallback = null;
         this._counterChangeCallback = null;
         this._shieldData = null;
         this._labelTF = null;
         if(this._shieldImg)
         {
            this._shieldImg.dispose();
            this._shieldImg = null;
         }
         this.shield = null;
         if(this._shieldImg2)
         {
            this._shieldImg2.dispose();
            this._shieldImg2 = null;
         }
         this.shield2 = null;
         if(this._plateImg)
         {
            this._plateImg.dispose();
            this._plateImg = null;
         }
         this.plate = null;
         if(this._leftImg)
         {
            this._leftImg.dispose();
            this._leftImg = null;
         }
         this.left = null;
         if(this._topImg)
         {
            this._topImg.dispose();
            this._topImg = null;
         }
         this.top = null;
         if(this._rightImg)
         {
            this._rightImg.dispose();
            this._rightImg = null;
         }
         this.right = null;
         if(this._bottomImg)
         {
            this._bottomImg.dispose();
            this._bottomImg = null;
         }
         this.bottom = null;
         this.counter = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = mouseChildren = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._shieldData && isInvalid(INVALID_ANIMATION))
         {
            this.updateElements();
            this.animate();
         }
      }
      
      public function animateState(param1:Function = null, param2:Function = null) : void
      {
         if(!this._shieldData)
         {
            if(param1 != null)
            {
               param1();
            }
            if(param2 != null)
            {
               param2();
            }
            return;
         }
         this._animateFinished = false;
         this._animateStateCallback = param1;
         this._counterChangeCallback = param2;
         invalidate(INVALID_ANIMATION);
      }
      
      public function getShieldOffset(param1:String) : Number
      {
         var _loc3_:String = null;
         var _loc2_:Boolean = false;
         if(this._shieldData)
         {
            _loc3_ = this._shieldData.state;
            if(this._animateFinished)
            {
               _loc2_ = RANKEDBATTLES_ALIASES.SHIELD_END_NOT_VISIBLE_STATES.indexOf(_loc3_) == Values.DEFAULT_INT;
            }
            else if(this._animateStateCallback != null)
            {
               if(_loc3_ == RANKEDBATTLES_ALIASES.SHIELD_LOSE)
               {
                  _loc2_ = false;
               }
               else if(_loc3_ == RANKEDBATTLES_ALIASES.SHIELD_FULL_RENEW || _loc3_ == RANKEDBATTLES_ALIASES.SHIELD_RENEW)
               {
                  _loc2_ = true;
               }
            }
            else
            {
               _loc2_ = RANKEDBATTLES_ALIASES.SHIELD_NOT_VISIBLE_STATES.indexOf(_loc3_) == Values.DEFAULT_INT;
            }
            return !!_loc2_ ? Number(SHIELD_OFFSETS[param1]) : Number(0);
         }
         return NaN;
      }
      
      public function setData(param1:RankShieldVO) : void
      {
         this._shieldData = param1;
         if(this._size != Values.EMPTY_STR)
         {
            this.updateElements();
         }
      }
      
      public function updateSize(param1:String) : void
      {
         this._size = param1;
         this._isHuge = param1 == RANKEDBATTLES_ALIASES.WIDGET_HUGE;
         this.updateElements();
      }
      
      private function updateElements() : void
      {
         if(this._shieldData)
         {
            this.setState(this._shieldData.state);
            this.defineElement();
         }
      }
      
      private function animate() : void
      {
         switch(this._shieldState)
         {
            case RANKEDBATTLES_ALIASES.SHIELD_LOSE_STEP:
               addFrameScript(this._frameHelper.getFrameByLabel(RANKEDBATTLES_ALIASES.SHIELD_LOSE_STEP_COUNTER),this.changeShieldCounter);
               addFrameScript(this._frameHelper.getFrameBeforeLabel(RANKEDBATTLES_ALIASES.SHIELD_LOSE_STEP_END),this.animationEnd);
               gotoAndPlay(this._shieldState);
               break;
            case RANKEDBATTLES_ALIASES.SHIELD_LOSE:
               addFrameScript(this._frameHelper.getFrameBeforeLabel(RANKEDBATTLES_ALIASES.SHIELD_LOSE_END),this.animationEnd);
               addFrameScript(this._frameHelper.getFrameBeforeLabel(RANKEDBATTLES_ALIASES.SHIELD_LOSE_COUNTER),this.changeShieldCounter);
               gotoAndPlay(this._shieldState);
               break;
            case RANKEDBATTLES_ALIASES.SHIELD_RENEW:
               addFrameScript(this._frameHelper.getFrameByLabel(RANKEDBATTLES_ALIASES.SHIELD_RENEW_COUNTER),this.changeShieldCounter);
               addFrameScript(this._frameHelper.getFrameBeforeLabel(RANKEDBATTLES_ALIASES.SHIELD_RENEW_END),this.animationEnd);
               gotoAndPlay(this._shieldState);
               break;
            case RANKEDBATTLES_ALIASES.SHIELD_FULL_RENEW:
               addFrameScript(this._frameHelper.getFrameBeforeLabel(RANKEDBATTLES_ALIASES.SHIELD_FULL_RENEW_END),this.animationEnd);
               addFrameScript(this._frameHelper.getFrameBeforeLabel(RANKEDBATTLES_ALIASES.SHIELD_FULL_RENEW_COUNTER),this.changeShieldCounter);
               gotoAndPlay(this._shieldState);
         }
      }
      
      private function setState(param1:String) : void
      {
         this._shieldState = param1;
         if(currentFrameLabel != param1)
         {
            if(param1 == RANKEDBATTLES_ALIASES.SHIELD_DISABLED)
            {
               gotoAndStop(RANKEDBATTLES_ALIASES.SHIELD_ENABLED);
            }
            else
            {
               gotoAndStop(param1);
            }
         }
         switch(param1)
         {
            case RANKEDBATTLES_ALIASES.SHIELD_ENABLED:
               this._shieldImg = this.shield.img;
               this._plateImg = this.plate.img;
               this._labelTF = this.counter.labelTF;
               break;
            case RANKEDBATTLES_ALIASES.SHIELD_DISABLED:
               this._shieldImg = this.shield.img;
               this._plateImg = this.plate.img;
               this._labelTF = this.counter.labelTF;
               break;
            case RANKEDBATTLES_ALIASES.SHIELD_FULL_RENEW:
            case RANKEDBATTLES_ALIASES.SHIELD_RENEW:
               this._labelTF = this.counter.labelTF;
               this._plateImg = this.plate.img;
               this._shieldImg = this.shield.img;
               this._shieldImg2 = this.shield2.img;
               break;
            case RANKEDBATTLES_ALIASES.SHIELD_LOSE:
               this._labelTF = this.counter.labelTF;
               this._plateImg = this.plate.img;
               this._topImg = this.top.img;
               this._bottomImg = this.bottom.img;
               this._rightImg = this.right.img;
               this._leftImg = this.left.img;
               break;
            case RANKEDBATTLES_ALIASES.SHIELD_LOSE_STEP:
               this._labelTF = this.counter.labelTF;
               this._plateImg = this.plate.img;
               if(this._isHuge)
               {
                  this._topImg = this.top.img;
                  this._bottomImg = this.bottom.img;
                  this._rightImg = this.right.img;
                  this._leftImg = this.left.img;
               }
               else
               {
                  this._shieldImg = this.shield.img;
               }
         }
         if(RANKEDBATTLES_ALIASES.SHIELD_COUNTER_CHANGE_STATES.indexOf(param1) != Values.DEFAULT_INT)
         {
            if(this._animateFinished)
            {
               this._labelTF.text = this._shieldData.label;
            }
            else
            {
               this._labelTF.text = this._shieldData.prevLabel;
            }
         }
         else
         {
            this._labelTF.text = this._shieldData.label;
         }
      }
      
      private function defineElement() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc1_:RankShieldAnimHelperVO = this._shieldData.animationData;
         _loc2_ = Boolean(_loc1_);
         this._plateImg.source = this._shieldData.plateImg;
         switch(this._shieldState)
         {
            case RANKEDBATTLES_ALIASES.SHIELD_ENABLED:
               this._shieldImg.source = this._shieldData.img;
               break;
            case RANKEDBATTLES_ALIASES.SHIELD_DISABLED:
               this._shieldImg.source = this._shieldData.img;
               this._labelTF.visible = this._shieldImg.visible = this._plateImg.visible = false;
               break;
            case RANKEDBATTLES_ALIASES.SHIELD_FULL_RENEW:
            case RANKEDBATTLES_ALIASES.SHIELD_RENEW:
               this._shieldImg.source = this._shieldData.img;
               this._shieldImg2.source = this._shieldData.img;
               break;
            case RANKEDBATTLES_ALIASES.SHIELD_LOSE:
               _loc3_ = _loc2_ && !this._animateFinished;
               if(_loc2_)
               {
                  this._topImg.source = _loc1_.topImg;
                  this._bottomImg.source = _loc1_.bottomImg;
                  this._leftImg.source = _loc1_.leftImg;
                  this._rightImg.source = _loc1_.rightImg;
               }
               this._topImg.visible = this._bottomImg.visible = this._leftImg.visible = this._rightImg.visible = _loc3_;
               break;
            case RANKEDBATTLES_ALIASES.SHIELD_LOSE_STEP:
               if(this._isHuge)
               {
                  if(_loc2_)
                  {
                     this._topImg.source = _loc1_.topImg;
                     this._bottomImg.source = _loc1_.bottomImg;
                     this._leftImg.source = _loc1_.leftImg;
                     this._rightImg.source = _loc1_.rightImg;
                  }
                  this._topImg.visible = this._bottomImg.visible = this._leftImg.visible = this._rightImg.visible = _loc2_;
               }
               else
               {
                  this._shieldImg.source = this._shieldData.img;
               }
         }
      }
      
      private function animationEnd() : void
      {
         if(this._animateStateCallback != null)
         {
            this._animateStateCallback();
         }
         if(StringUtils.isNotEmpty(this._shieldData.newState))
         {
            this._shieldState = this._shieldData.newState;
         }
         this._animateFinished = true;
         this._animateStateCallback = null;
      }
      
      private function changeShieldCounter() : void
      {
         this._labelTF.text = this._shieldData.label;
         if(!this._plateImg.visible)
         {
            this._plateImg.visible = true;
         }
         if(this._counterChangeCallback != null)
         {
            this._counterChangeCallback();
            this._counterChangeCallback = null;
         }
      }
   }
}
