package net.wg.gui.lobby.tankman
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.components.advanced.DashLine;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.VO.PersonalCaseBlockItemVO;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.Extensions;
   
   public class PersonalCaseBlockItem extends UIComponentEx
   {
      
      private static const FULL_DASH_WIDTH:int = 478;
      
      private static const NEW_SKILLS_PADDING:int = 4;
      
      private static const LEFT_DASH_WIDTH:int = 332;
      
      private static const RIGHT_DASH_PADDING:int = 16;
      
      private static const RIGHT_DASH_WIDTH:int = 131;
      
      private static const VALUE_MARGIN:int = 3;
       
      
      public var skills:UILoaderAlt;
      
      public var value:TextField;
      
      public var valuePrem:TextField;
      
      public var label:TextField;
      
      public var leftDashLine:DashLine = null;
      
      public var rightDashLine:DashLine = null;
      
      private var model:PersonalCaseBlockItemVO;
      
      private var _tankmanID:int = -1;
      
      private var _skillName:String = null;
      
      private var isStudying:Boolean = false;
      
      public function PersonalCaseBlockItem()
      {
         super();
         this.label.autoSize = TextFieldAutoSize.LEFT;
         this.value.autoSize = TextFieldAutoSize.RIGHT;
         this.valuePrem.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      public function useBlocks(param1:Boolean, param2:Boolean) : void
      {
         this.isStudying = param1;
         if(param1)
         {
            this.leftDashLine.width = LEFT_DASH_WIDTH;
            this.rightDashLine.x = this.leftDashLine.x + this.leftDashLine.width + RIGHT_DASH_PADDING;
            this.rightDashLine.width = RIGHT_DASH_WIDTH;
            this.value.alpha = !!param2 ? Number(0.3) : Number(1);
            this.valuePrem.alpha = !param2 ? Number(0.3) : Number(1);
         }
         else
         {
            this.leftDashLine.width = FULL_DASH_WIDTH;
            this.rightDashLine.visible = false;
         }
      }
      
      public function setData(param1:PersonalCaseBlockItemVO) : void
      {
         var _loc3_:String = null;
         this.model = param1;
         var _loc2_:String = !!Extensions.isScaleform ? MENU.profile_stats_items(this.model.name) : this.model.name;
         if(this.model.imageType != Values.EMPTY_STR && this.model.imageType == "new_skill")
         {
            _loc2_ = MENU.PROFILE_STATS_ITEMS_READYTOLEARN;
            _loc3_ = "../maps/icons/tankmen/skills/small/" + this.model.image;
            this.addListenersToIcon();
            this.value.visible = false;
            this.valuePrem.visible = false;
         }
         else if(this.model.imageType != Values.EMPTY_STR && this.model.imageType == "role")
         {
            _loc3_ = "../maps/icons/tankmen/roles/small/" + this.model.image;
            this.skills.y += 2;
         }
         else if(this.model.imageType != Values.EMPTY_STR && this.model.imageType == "skill")
         {
            _loc3_ = "../maps/icons/tankmen/skills/small/" + this.model.image;
            this.addListenersToIcon();
         }
         if(this.model.extra != Values.EMPTY_STR && this.model.extra != null)
         {
            this.value.visible = true;
            this.valuePrem.visible = true;
            this.value.text = this.model.extra;
            this.valuePrem.text = this.model.extra;
            this.updateLeftValue();
            this.updateRightValue();
         }
         if(this.value.visible && this.model.value != null && this.model.value != Values.EMPTY_STR)
         {
            this.value.text = this.model.value;
            this.updateLeftValue();
            if(this.isStudying)
            {
               this.valuePrem.text = this.model.premiumValue;
               this.updateRightValue();
            }
            else
            {
               this.valuePrem.visible = false;
            }
         }
         this.label.text = _loc2_;
         if(_loc3_)
         {
            this.skills.source = _loc3_;
            this.skills.x = this.label.x + this.label.width + NEW_SKILLS_PADDING ^ 0;
         }
      }
      
      public function getTankmanID(param1:int, param2:String) : void
      {
         this._tankmanID = param1;
         this._skillName = param2;
      }
      
      override protected function onDispose() : void
      {
         this.leftDashLine.dispose();
         this.leftDashLine = null;
         this.rightDashLine.dispose();
         this.rightDashLine = null;
         this.skills.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.skills.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.skills.removeEventListener(MouseEvent.CLICK,this.skills_mouseClickHandler);
         this.skills.removeEventListener(ButtonEvent.CLICK,this.skills_buttonClickHandler);
         this.skills.dispose();
         this.skills = null;
         this.value = null;
         this.label = null;
         this.model.dispose();
         this.model = null;
         this._skillName = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.GET_TANKMAN_ID,true);
         _loc1_.tankmanIdDelegate = this.getTankmanID;
         dispatchEvent(_loc1_);
      }
      
      private function updateLeftValue() : void
      {
         this.value.x = this.leftDashLine.x + this.leftDashLine.width - this.value.width + VALUE_MARGIN ^ 0;
      }
      
      private function updateRightValue() : void
      {
         this.valuePrem.x = this.rightDashLine.x + this.rightDashLine.width - this.valuePrem.width + VALUE_MARGIN ^ 0;
      }
      
      private function addListenersToIcon() : void
      {
         this.skills.mouseChildren = false;
         this.skills.buttonMode = true;
         this.skills.useHandCursor = true;
         this.skills.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.skills.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.skills.addEventListener(MouseEvent.CLICK,this.skills_mouseClickHandler);
         this.skills.addEventListener(ButtonEvent.CLICK,this.skills_buttonClickHandler);
      }
      
      private function dispatchPersonalCaseEvent() : void
      {
         dispatchEvent(new PersonalCaseEvent(PersonalCaseEvent.CHANGE_TAB_ON_TWO,true));
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         if(!this.model.hasOwnProperty("name") && !this.model.hasOwnProperty("tankmanID") && this.model.name != null)
         {
            return;
         }
         if(this.model.hasOwnProperty("imageType") && this.model.imageType == "new_skill")
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TANKMAN_NEW_SKILL,TooltipProps.DEFAULT,this._tankmanID);
         }
         else
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TANKMAN_SKILL,null,this._skillName,this._tankmanID);
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function skills_buttonClickHandler(param1:ButtonEvent) : void
      {
         this.dispatchPersonalCaseEvent();
      }
      
      private function skills_mouseClickHandler(param1:MouseEvent) : void
      {
         this.dispatchPersonalCaseEvent();
      }
   }
}
