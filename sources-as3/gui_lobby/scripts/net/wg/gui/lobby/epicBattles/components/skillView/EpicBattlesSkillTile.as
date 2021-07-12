package net.wg.gui.lobby.epicBattles.components.skillView
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.epicBattles.data.EpicBattleSkillVO;
   import net.wg.gui.lobby.epicBattles.events.EpicBattlesSkillViewClickEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class EpicBattlesSkillTile extends UIComponentEx implements IUpdatable
   {
      
      public static const MIN_RES_STATE:String = "minres";
      
      public static const REG_RES_STATE:String = "regular";
      
      private static const UP_STATE:String = "up";
      
      private static const OVER_STATE:String = "over";
      
      private static const OUT_STATE:String = "out";
      
      private static const SELECTED_UP_STATE:String = "selected_up";
      
      private static const SELECTED_OVER_STATE:String = "selected_over";
      
      private static const SELECTED_OUT_STATE:String = "selected_out";
      
      public static const WIDTH:int = 204;
      
      public static const HEIGHT:int = 184;
      
      public static const BIG_WIDTH:int = 246;
      
      public static const BIG_HEIGHT:int = 246;
      
      private static const ICON_MIN_RES_SCALE:Number = 0.75;
      
      private static const ICON_REG_RES_SCALE:Number = 1;
      
      private static const ICON_MIN_RES_OFFSET:int = 10;
      
      private static const ICON_REG_RES_OFFSET:int = 15;
       
      
      public var titleTF:TextField = null;
      
      public var subtitleTF:TextField = null;
      
      public var skillIcon:EpicBattlesSkillImage = null;
      
      public var background:MovieClip = null;
      
      private var _state:String = "minres";
      
      private var _bgState:String = "";
      
      private var _selected:Boolean = false;
      
      private var _data:EpicBattleSkillVO = null;
      
      private var _titleSet:Boolean = false;
      
      public function EpicBattlesSkillTile()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            if(!this._titleSet)
            {
               this.titleTF.htmlText = this._state == MIN_RES_STATE ? this._data.smallTitle : this._data.title;
               this._titleSet = true;
            }
            this.subtitleTF.htmlText = this._data.label;
            this.skillIcon.source = this._data.iconUrl;
            this.skillIcon.switchColorization(Boolean(this._data.level));
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(this._state == MIN_RES_STATE)
            {
               this.skillIcon.y = ICON_MIN_RES_OFFSET;
               this.skillIcon.scaleX = this.skillIcon.scaleY = ICON_MIN_RES_SCALE;
               this.titleTF.htmlText = this._data.smallTitle;
            }
            else
            {
               this.skillIcon.y = ICON_REG_RES_OFFSET;
               this.skillIcon.scaleX = this.skillIcon.scaleY = ICON_REG_RES_SCALE;
               this.titleTF.htmlText = this._data.title;
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRendererRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRendererRollOutHandler);
         addEventListener(MouseEvent.CLICK,this.onSkillTileMouseClickHandler);
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.background.stop();
         removeEventListener(MouseEvent.ROLL_OVER,this.onRendererRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRendererRollOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onSkillTileMouseClickHandler);
         this.titleTF = null;
         this.subtitleTF = null;
         this.skillIcon.dispose();
         this.skillIcon = null;
         this.background = null;
         this._data.removeEventListener(Event.CHANGE,this.onSkillVOChangeHandler);
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         this._data = EpicBattleSkillVO(param1);
         this._data.addEventListener(Event.CHANGE,this.onSkillVOChangeHandler);
         invalidateData();
      }
      
      private function setBackgroundState(param1:String) : void
      {
         if(this._bgState == param1)
         {
            return;
         }
         this._bgState = param1;
         this.background.gotoAndPlay(param1);
      }
      
      override public function get width() : Number
      {
         return this._state == MIN_RES_STATE ? Number(WIDTH) : Number(BIG_WIDTH);
      }
      
      override public function get height() : Number
      {
         return this._state == MIN_RES_STATE ? Number(HEIGHT) : Number(BIG_HEIGHT);
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
         this.setBackgroundState(!!param1 ? SELECTED_UP_STATE : UP_STATE);
      }
      
      public function set state(param1:String) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         invalidateState();
         gotoAndPlay(param1);
      }
      
      private function onSkillTileMouseClickHandler(param1:MouseEvent) : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.NORMAL_BTN,null);
         dispatchEvent(new EpicBattlesSkillViewClickEvent(EpicBattlesSkillViewClickEvent.SLOT_ITEM_CLICKED,this._data.skillID,true));
      }
      
      private function onRendererRollOutHandler(param1:MouseEvent) : void
      {
         this.setBackgroundState(!!this._selected ? SELECTED_OUT_STATE : OUT_STATE);
         App.toolTipMgr.hide();
      }
      
      private function onRendererRollOverHandler(param1:MouseEvent) : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.NORMAL_BTN,null);
         if(this._data)
         {
            this.setBackgroundState(!!this._selected ? SELECTED_OVER_STATE : OVER_STATE);
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.EPIC_SKILL_INFO,null,this._data.skillID,this._data.level);
         }
      }
      
      private function onSkillVOChangeHandler(param1:Event) : void
      {
         invalidateData();
      }
   }
}
