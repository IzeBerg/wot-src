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
      
      private static const OVER_LABEL:String = "over";
      
      private static const DISABLED_LABEL:String = "disabled";
       
      
      public var clickArea:MovieClip;
      
      public var icon:UILoaderAlt;
      
      public var rank:SkillsItemsRendererRankIcon;
      
      public var _name:TextField;
      
      public var desc:TextField;
      
      public var focusIndicatorUI:MovieClip;
      
      private var _isHeader:Boolean = false;
      
      private var _mouseOver:Boolean = false;
      
      private const UPDATE_DATA:String = "updateData";
      
      private const HEADER_PREFIX:String = "header_";
      
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
         this.clickArea = null;
         this.icon = null;
         this.rank = null;
         this._name = null;
         this.desc = null;
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
         if(_data != null && isInvalid(this.UPDATE_DATA))
         {
            this.updateData();
         }
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         if(this._isHeader)
         {
            return Vector.<String>([this.HEADER_PREFIX,Values.EMPTY_STR]);
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
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TANKMAN_SKILL,null,data.title,data.tankmanID);
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
            this._name.text = App.utils.toUpperOrLowerCase(App.utils.locale.makeString("#dialogs:addSkillWindow/label/" + data.title),true);
            this.desc.text = data.rankId == "common" || data.selfSkill ? "" : "#item_types:tankman/Skill_not_be_used";
            this.rank.visible = false;
         }
         else
         {
            this.addEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClickHandler);
            this._name.text = data.name;
            this.desc.visible = true;
            this.desc.text = data.desc;
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
         var _loc1_:String = null;
         this._isHeader = data.isHeader;
         if(data.isHeader || !data.enabled)
         {
            enabled = false;
         }
         if(!this._isHeader)
         {
            if(!this.icon.visible)
            {
               this.icon.visible = true;
            }
            _loc1_ = "../maps/icons/tankmen/skills/big/" + data.title + ".png";
            this.icon.source = _loc1_;
         }
         else
         {
            this.icon.visible = false;
         }
         invalidate(this.UPDATE_DATA);
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
