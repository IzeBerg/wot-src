package net.wg.gui.lobby.epicBattles.components.prestigeView
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.BaseMetaLevel;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.data.MetaLevelVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class RewardRibbon extends UIComponentEx
   {
      
      private static const SHOW_RIBBON_STATE:String = "showRibbon";
      
      private static const END_FRAME:int = 32;
      
      private static const RIBBON_RED_LABEL_TEMPLATE:String = "red_";
      
      private static const RIBBON_GOLD_LABEL_TEMPLATE:String = "gold_";
      
      private static const LEVEL_OFFSET_Y_LARGE:int = -10;
      
      private static const LEVEL_OFFSET_Y_EXTRA_LARGE:int = -16;
      
      private static const AWARDS_OFFSET_Y_LARGE:int = 30;
      
      private static const AWARDS_OFFSET_Y_EXTRA_LARGE:int = 40;
      
      private static const AWARDS_GAP_SMALL:int = 20;
      
      private static const AWARDS_GAP_BIG:int = 40;
      
      public static const SIZE_BIG:String = "big";
      
      public static const SIZE_MEDIUM:String = "medium";
      
      public static const SIZE_SMALL:String = "small";
       
      
      public var awardsCont:AwardsRibbonAnim = null;
      
      public var levelCont:MovieClip = null;
      
      public var glow:MovieClip = null;
      
      public var ribbon:MovieClip = null;
      
      private var _epicMetaLevelRegular:BaseMetaLevel = null;
      
      private var _initialAwardsY:int = 0;
      
      private var _initialLevelY:int = 0;
      
      private var _state:String = "";
      
      private var _ribbonSize:String = "small";
      
      private var _isMaxLevel:Boolean = false;
      
      public function RewardRibbon()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         stop();
         addFrameScript(END_FRAME,null);
         var _loc1_:DisplayObjectContainer = this.levelCont.level;
         _loc1_.removeChild(this._epicMetaLevelRegular);
         this.levelCont = null;
         this._epicMetaLevelRegular.dispose();
         this._epicMetaLevelRegular = null;
         this.awardsCont.dispose();
         this.awardsCont = null;
         this.glow = null;
         this.ribbon = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.awardsCont.awardGap = AWARDS_GAP_SMALL;
         this.awardsCont.awardSize = AwardsRibbonAnim.AWARD_SIZE_BIG;
         this._initialAwardsY = this.awardsCont.y;
         this._initialLevelY = this.levelCont.y;
         addFrameScript(END_FRAME,this.onShowRibbonAnimationComplete);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            if(this._ribbonSize == SIZE_SMALL)
            {
               this._epicMetaLevelRegular.setIconSize(BaseMetaLevel.MEDIUM);
               this.awardsCont.awardSize = AwardsRibbonAnim.AWARD_SIZE_SMALL;
               this.awardsCont.awardGap = AWARDS_GAP_SMALL;
            }
            else if(this._ribbonSize == SIZE_MEDIUM)
            {
               this._epicMetaLevelRegular.setIconSize(BaseMetaLevel.LARGE);
               this.awardsCont.awardSize = AwardsRibbonAnim.AWARD_SIZE_BIG;
               this.awardsCont.awardGap = AWARDS_GAP_BIG;
            }
            else
            {
               this._epicMetaLevelRegular.setIconSize(BaseMetaLevel.EXTRA_LARGE);
               this.awardsCont.awardSize = AwardsRibbonAnim.AWARD_SIZE_BIG;
               this.awardsCont.awardGap = AWARDS_GAP_BIG;
            }
            this.levelCont.y = this._initialLevelY;
            this.awardsCont.y = this._initialAwardsY;
            _loc1_ = !!this._isMaxLevel ? RIBBON_GOLD_LABEL_TEMPLATE : RIBBON_RED_LABEL_TEMPLATE;
            if(this._ribbonSize == SIZE_MEDIUM)
            {
               this.levelCont.y += LEVEL_OFFSET_Y_LARGE;
               this.awardsCont.y += AWARDS_OFFSET_Y_LARGE;
            }
            else if(this._ribbonSize == SIZE_BIG)
            {
               this.levelCont.y += LEVEL_OFFSET_Y_EXTRA_LARGE;
               this.awardsCont.y += AWARDS_OFFSET_Y_EXTRA_LARGE;
            }
            _loc1_ += this._ribbonSize;
            this.ribbon.gotoAndStop(_loc1_);
         }
      }
      
      public function setAwards(param1:Vector.<AwardItemRendererExVO>) : void
      {
         this.awardsCont.setAwards(param1);
      }
      
      public function setLevel(param1:MetaLevelVO, param2:String, param3:Boolean = false) : void
      {
         this._epicMetaLevelRegular = App.utils.classFactory.getComponent(param2,BaseMetaLevel);
         var _loc4_:DisplayObjectContainer = this.levelCont.level;
         _loc4_.addChild(this._epicMetaLevelRegular);
         this._isMaxLevel = param3;
         this._epicMetaLevelRegular.setData(param1);
         this.glow.visible = param3;
      }
      
      public function set ribbonSize(param1:String) : void
      {
         if(this._ribbonSize != param1)
         {
            this._ribbonSize = param1;
            invalidateLayout();
         }
      }
      
      public function show() : void
      {
         this.setState(SHOW_RIBBON_STATE);
      }
      
      private function setState(param1:String) : void
      {
         if(param1 == this._state)
         {
            return;
         }
         this._state = param1;
         gotoAndPlay(param1);
         this.levelCont.gotoAndPlay(param1);
      }
      
      private function onShowRibbonAnimationComplete() : void
      {
         this.awardsCont.show();
      }
   }
}
