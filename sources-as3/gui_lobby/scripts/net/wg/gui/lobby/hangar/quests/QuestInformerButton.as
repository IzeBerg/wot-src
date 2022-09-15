package net.wg.gui.lobby.hangar.quests
{
   import fl.motion.easing.Quartic;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.hangar.data.HeaderQuestsVO;
   import net.wg.gui.lobby.hangar.interfaces.IQuestInformerButton;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class QuestInformerButton extends SoundButtonEx implements IQuestInformerButton
   {
      
      private static const INVALIDATE_FIELDS:String = "invFields";
      
      private static const GLOW_FIRST_FRAME_ANIM:int = 0;
      
      private static const REWARD_ANIM_FIRST_FRAME:int = 0;
      
      private static const CONTENT_DEFAULT_Y_POSITION:int = 0;
      
      private static const CONTENT_HIDED_Y_POSITION:int = 20;
      
      private static const CONTENT_SHOW_ALPHA:int = 1;
      
      private static const CONTENT_HIDE_ALPHA:int = 0;
      
      private static const TWEEN_DURATION:int = 200;
      
      private static const TWEEN_SHOW_DELAY_DURATION:int = 200;
       
      
      public var content:QuestInformerContent;
      
      public var switchGlowMc:MovieClip;
      
      public var flagContainer:FlagContainer;
      
      public var flagGray:FlagContainer;
      
      public var rewardAnimMc:MovieClip;
      
      public var hover:Sprite;
      
      public var hoverFlipped:Sprite;
      
      private var _questVO:HeaderQuestsVO = null;
      
      private var _collapsePoint:Point = null;
      
      private var _expandPoint:Point = null;
      
      private var _tweenHide:Tween = null;
      
      private var _tweenShow:Tween = null;
      
      private var _isHorizontalFlipped:Boolean = false;
      
      public function QuestInformerButton()
      {
         super();
         this._collapsePoint = new Point();
         this._expandPoint = new Point();
         this._tweenHide = new Tween(TWEEN_DURATION,this.content,{
            "y":CONTENT_DEFAULT_Y_POSITION,
            "alpha":CONTENT_HIDE_ALPHA
         },{
            "paused":true,
            "ease":Quartic.easeOut,
            "delay":0,
            "fastTransform":false
         });
         this._tweenShow = new Tween(TWEEN_DURATION,this.content,{
            "y":CONTENT_DEFAULT_Y_POSITION,
            "alpha":CONTENT_SHOW_ALPHA
         },{
            "paused":true,
            "ease":Quartic.easeOut,
            "delay":TWEEN_SHOW_DELAY_DURATION,
            "fastTransform":false
         });
      }
      
      override public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
         super.gotoAndPlay(param1,param2);
         if(this.content)
         {
            this.content.gotoAndPlay(param1,param2);
         }
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         super.gotoAndStop(param1,param2);
         if(this.content)
         {
            this.content.gotoAndStop(param1,param2);
         }
      }
      
      override protected function preInitialize() : void
      {
         constraintsDisabled = true;
         preventAutosizing = true;
         super.preInitialize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabledOnDisabled = true;
      }
      
      override protected function onDispose() : void
      {
         this._tweenHide.dispose();
         this._tweenHide = null;
         this._tweenShow.dispose();
         this._tweenShow = null;
         this.content.dispose();
         this.content = null;
         this._collapsePoint = null;
         this._expandPoint = null;
         this.switchGlowMc = null;
         this.flagContainer.dispose();
         this.flagContainer = null;
         this.flagGray.dispose();
         this.flagGray = null;
         this.rewardAnimMc = null;
         this.hover = null;
         this.hoverFlipped = null;
         this._questVO = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._questVO && isInvalid(InvalidationType.DATA))
         {
            this.content.updateData(this._questVO.icon,this._questVO.stateIcon,this._questVO.label);
            this.rewardAnimMc.visible = this._questVO.isReward;
            if(this._questVO.isReward)
            {
               this.rewardAnimMc.gotoAndPlay(REWARD_ANIM_FIRST_FRAME);
            }
            else
            {
               this.rewardAnimMc.stop();
            }
            this.flagContainer.setFlag(this._questVO.flag,this._isHorizontalFlipped);
            this.flagGray.setFlag(this._questVO.flagDisabled,this._isHorizontalFlipped);
            if(this._isHorizontalFlipped)
            {
               this.hover.alpha = 0;
            }
            else
            {
               this.hoverFlipped.alpha = 0;
            }
            invalidate(INVALIDATE_FIELDS);
         }
         if(isInvalid(INVALIDATE_FIELDS) && !isInvalid(INVALIDATE_FIELDS) && enabled)
         {
            this.switchGlowMc.gotoAndPlay(GLOW_FIRST_FRAME_ANIM);
         }
      }
      
      override protected function showTooltip() : void
      {
         if(this._questVO)
         {
            if(this._questVO.isTooltipSpecial)
            {
               App.toolTipMgr.showSpecial(this._questVO.tooltip,null,this._questVO.questType,this._questVO.questID);
            }
            else if(this._questVO.isTooltipWulf)
            {
               App.toolTipMgr.showWulfTooltip(this._questVO.tooltip,null);
            }
            else
            {
               super.showTooltip();
            }
         }
         else
         {
            super.showTooltip();
         }
      }
      
      public function hideContent(param1:Boolean, param2:int) : void
      {
         this._tweenShow.paused = true;
         if(param1)
         {
            this.content.y = CONTENT_DEFAULT_Y_POSITION;
            this.content.alpha = CONTENT_HIDE_ALPHA;
         }
         else
         {
            this._tweenHide.reset();
            this._tweenHide.paused = false;
         }
      }
      
      public final function setCollapsePoint(param1:int, param2:int) : void
      {
         this._collapsePoint.x = param1;
         this._collapsePoint.y = param2;
      }
      
      public function setData(param1:HeaderQuestsVO, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._questVO = param1;
         this.enabled = this._questVO.enable;
         tooltip = this._questVO.tooltip;
         this._isHorizontalFlipped = param2;
         invalidateData();
      }
      
      public final function setExpandPoint(param1:int, param2:int) : void
      {
         this._expandPoint.x = param1;
         this._expandPoint.y = param2;
      }
      
      public function showContent(param1:Boolean, param2:int) : void
      {
         this._tweenHide.paused = true;
         if(param1)
         {
            this.content.y = CONTENT_DEFAULT_Y_POSITION;
            this.content.alpha = CONTENT_SHOW_ALPHA;
         }
         else
         {
            this.content.y = CONTENT_HIDED_Y_POSITION;
            this._tweenShow.reset();
            this._tweenShow.delay = TWEEN_SHOW_DELAY_DURATION + param2;
            this._tweenShow.paused = false;
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.switchGlowMc.visible = param1;
      }
      
      public function get questType() : String
      {
         if(this._questVO)
         {
            return this._questVO.questType;
         }
         return Values.EMPTY_STR;
      }
      
      public function get questID() : String
      {
         if(this._questVO)
         {
            return this._questVO.questID;
         }
         return Values.EMPTY_STR;
      }
      
      public final function get collapsePoint() : Point
      {
         return this._collapsePoint;
      }
      
      public final function get expandPoint() : Point
      {
         return this._expandPoint;
      }
      
      public function get isEnable() : Boolean
      {
         return this.enabled;
      }
   }
}
