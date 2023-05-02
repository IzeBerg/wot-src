package net.wg.gui.lobby.tankman
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import scaleform.clik.events.ButtonEvent;
   
   public class PersonalCaseSkillsItemRenderer extends SoundListItemRenderer
   {
      
      public static const SKILL_DOUBLE_CLICK:String = "skillDoubleClick";
      
      private static const UPDATE_DATA:String = "updateData";
      
      private static const HEADER_PREFIX:String = "header_";
      
      private static const OVER_LABEL:String = "over";
      
      private static const DISABLED_LABEL:String = "disabled";
      
      private static const SITUATIONAL_X_SHIFT:int = 3;
      
      private static const SITUATIONAL_Y_SHIFT:int = -15;
       
      
      public var clickArea:MovieClip;
      
      public var icon:UILoaderAlt;
      
      public var rank:SkillsItemsRendererRankIcon;
      
      public var nameLabel:TextField;
      
      public var descLabel:TextField;
      
      public var focusIndicatorUI:MovieClip;
      
      public var iconSituational:MovieClip;
      
      private var _isHeader:Boolean = false;
      
      private var _mouseOver:Boolean = false;
      
      public function PersonalCaseSkillsItemRenderer()
      {
         super();
         soundType = SoundTypes.RNDR_NORMAL;
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 == null)
         {
            if(this.visible)
            {
               this.visible = false;
            }
            return;
         }
         if(!this.visible)
         {
            this.visible = true;
         }
         super.setData(param1);
         this._isHeader = param1.isHeader;
         if(!this._isHeader && param1.enabled && this._mouseOver)
         {
            setState(OVER_LABEL);
            App.utils.scheduler.scheduleTask(this.showTooltip,100);
         }
         else
         {
            if(this._isHeader || !param1.enabled)
            {
               setState(DISABLED_LABEL);
            }
            this.hideTooltip();
         }
         this.initVisibleElements();
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.showTooltip);
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClickHandler);
         if(this.icon)
         {
            this.icon.dispose();
         }
         if(this.rank)
         {
            this.rank.dispose();
         }
         this.focusIndicatorUI = null;
         this.iconSituational = null;
         this.clickArea = null;
         this.icon = null;
         this.rank = null;
         this.nameLabel = null;
         this.descLabel = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         buttonMode = true;
         allowDeselect = false;
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(_data != null && isInvalid(UPDATE_DATA))
         {
            this.updateData();
         }
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         if(this._isHeader)
         {
            return Vector.<String>([HEADER_PREFIX,Values.EMPTY_STR]);
         }
         return super.getStatePrefixes();
      }
      
      public function hideTooltip() : void
      {
         App.utils.scheduler.cancelTask(this.showTooltip);
         if(!this._isHeader)
         {
            App.toolTipMgr.hide();
         }
      }
      
      public function showTooltip() : void
      {
         if(!this._isHeader)
         {
            App.toolTipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.CREW_PERK_GF,data.title,data.tankmanID);
         }
         else
         {
            App.toolTipMgr.hide();
         }
      }
      
      private function updateData() : void
      {
         var _loc1_:String = null;
         if(this._isHeader)
         {
            this.nameLabel.text = App.utils.toUpperOrLowerCase(App.utils.locale.makeString("#dialogs:addSkillWindow/label/" + data.title),true);
            this.descLabel.text = data.rankId == "common" || data.selfSkill ? "" : "#item_types:tankman/Skill_not_be_used";
            this.rank.visible = this.iconSituational.visible = false;
         }
         else
         {
            this.addEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClickHandler);
            this.nameLabel.text = data.name;
            this.descLabel.text = data.desc;
            this.iconSituational.visible = data.isSituationalSkill;
            if(this.iconSituational.visible)
            {
               this.iconSituational.x = Math.round(this.nameLabel.x + this.nameLabel.textWidth + SITUATIONAL_X_SHIFT);
               this.iconSituational.y = Math.round(this.nameLabel.y + this.nameLabel.textHeight + SITUATIONAL_Y_SHIFT);
            }
            if(data.title == "common")
            {
               this.rank.visible = false;
            }
            else if(data.rankId != "common")
            {
               this.rank.visible = true;
               this.rank.gotoAndStop(Boolean(data.enabled) ? "enabled" : "disabled");
               _loc1_ = "../maps/icons/tankmen/roles/small/" + data.rankId + ".png";
               this.rank.setData(_loc1_,data.enabled);
               this.rank.validateNow();
            }
            else
            {
               this.rank.visible = false;
            }
         }
      }
      
      private function initVisibleElements() : void
      {
         var _loc2_:String = null;
         var _loc1_:PersonalCaseSkillModel = this.data as PersonalCaseSkillModel;
         this._isHeader = _loc1_.isHeader;
         if(_loc1_.isHeader || !_loc1_.enabled)
         {
            enabled = false;
         }
         if(!this._isHeader)
         {
            if(!this.icon.visible)
            {
               this.icon.visible = true;
            }
            _loc2_ = "../maps/icons/tankmen/skills/big/" + _loc1_.iconName + ".png";
            this.icon.source = _loc2_;
         }
         else
         {
            this.icon.visible = false;
         }
         invalidate(UPDATE_DATA);
      }
      
      public function onSelect(param1:ButtonEvent) : void
      {
         if(!this._isHeader)
         {
            App.toolTipMgr.hide();
         }
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent = null) : void
      {
         this._mouseOver = false;
         this.hideTooltip();
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent = null) : void
      {
         this._mouseOver = true;
         this.showTooltip();
      }
      
      private function onDoubleClickHandler(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            dispatchEvent(new Event(SKILL_DOUBLE_CLICK,true));
         }
      }
   }
}
