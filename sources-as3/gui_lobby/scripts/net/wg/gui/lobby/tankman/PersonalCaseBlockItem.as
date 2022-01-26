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
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.gui.lobby.tankman.vo.PersonalCaseBlockItemVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.Extensions;
   
   public class PersonalCaseBlockItem extends UIComponentEx
   {
      
      private static const NEW_SKILLS_PADDING:int = 4;
      
      private static const FULL_DASH_WIDTH:int = 478;
      
      private static const LEFT_DASH_WIDTH:int = 332;
      
      private static const RIGHT_DASH_WIDTH:int = 131;
      
      private static const VALUE_MARGIN:int = 3;
      
      private static const SKILL_Y:int = 4;
      
      private static const SKILL_Y_ROLE:int = 6;
      
      private static const INACTIVE_ALPHA:Number = 0.3;
      
      private static const ROLE_ICON_SIZE:String = "small";
      
      private static const ICON_TYPE_NEW_SKILL:String = "new_skill";
      
      private static const ICON_TYPE_ROLE:String = "role";
      
      private static const ICON_TYPE_SKILL:String = "skill";
       
      
      public var skills:UILoaderAlt;
      
      public var value:TextField;
      
      public var secondValue:TextField;
      
      public var label:TextField;
      
      public var leftDashLine:DashLine = null;
      
      public var rightDashLine:DashLine = null;
      
      private var _model:PersonalCaseBlockItemVO;
      
      private var _isSecondValue:Boolean = false;
      
      private var _tankmanID:int = -1;
      
      private var _skillName:String = null;
      
      public function PersonalCaseBlockItem()
      {
         super();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA) && this._model)
         {
            this.validateDate();
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.validateLayout();
         }
      }
      
      override protected function onDispose() : void
      {
         this.leftDashLine.dispose();
         this.leftDashLine = null;
         this.rightDashLine.dispose();
         this.rightDashLine = null;
         this.skills.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.skills.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.skills.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.skills.dispose();
         this.skills = null;
         this.value = null;
         this.secondValue = null;
         this.label = null;
         this._model.dispose();
         this._model = null;
         this._skillName = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.label.autoSize = TextFieldAutoSize.LEFT;
         this.value.autoSize = TextFieldAutoSize.RIGHT;
         this.secondValue.autoSize = TextFieldAutoSize.RIGHT;
         this.rightDashLine.width = RIGHT_DASH_WIDTH;
         this.skills.mouseChildren = false;
         this.skills.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.skills.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.skills.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         var _loc1_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.GET_TANKMAN_ID,true);
         _loc1_.tankmanIdDelegate = this.getTankmanID;
         dispatchEvent(_loc1_);
      }
      
      public function getTankmanID(param1:int, param2:String) : void
      {
         this._tankmanID = param1;
         this._skillName = param2;
      }
      
      public function setData(param1:PersonalCaseBlockItemVO, param2:Boolean) : void
      {
         this._model = param1;
         this._isSecondValue = param2;
         invalidateData();
         invalidateLayout();
      }
      
      private function validateLayout() : void
      {
         this.leftDashLine.width = !!this._isSecondValue ? Number(LEFT_DASH_WIDTH) : Number(FULL_DASH_WIDTH);
         this.value.x = this.leftDashLine.x + this.leftDashLine.width - this.value.width + VALUE_MARGIN ^ 0;
         this.secondValue.x = this.rightDashLine.x + this.rightDashLine.width - this.secondValue.width + VALUE_MARGIN ^ 0;
         this.skills.y = this._model.imageType == ICON_TYPE_ROLE ? Number(SKILL_Y_ROLE) : Number(SKILL_Y);
         this.skills.x = this.label.x + this.label.width + NEW_SKILLS_PADDING ^ 0;
      }
      
      private function setSkillsInteractive(param1:Boolean) : void
      {
         this.skills.buttonMode = this.skills.mouseEnabled = param1;
      }
      
      private function validateDate() : void
      {
         if(this._model.imageType == ICON_TYPE_NEW_SKILL)
         {
            this.label.text = MENU.PROFILE_STATS_ITEMS_READYTOLEARN;
         }
         else
         {
            this.label.text = !!Extensions.isScaleform ? MENU.profile_stats_items(this._model.name) : this._model.name;
         }
         if(this._model.imageType == ICON_TYPE_NEW_SKILL || this._model.imageType == ICON_TYPE_SKILL)
         {
            this.skills.source = RES_ICONS.maps_icons_tankmen_skills_small(this._model.image);
            this.setSkillsInteractive(true);
         }
         else if(this._model.imageType == ICON_TYPE_ROLE)
         {
            this.skills.source = RES_ICONS.getTankmanRoleIcon(ROLE_ICON_SIZE,this._model.image);
            this.setSkillsInteractive(false);
         }
         else
         {
            this.setSkillsInteractive(false);
         }
         this.value.visible = StringUtils.isNotEmpty(this._model.value) && this._model.imageType != ICON_TYPE_NEW_SKILL;
         this.secondValue.visible = this._isSecondValue && StringUtils.isNotEmpty(this._model.secondValue) && this._model.imageType != ICON_TYPE_NEW_SKILL;
         this.value.text = this._model.value;
         this.secondValue.text = this._model.secondValue;
         this.label.alpha = !!this._model.isLabelActive ? Number(Values.DEFAULT_ALPHA) : Number(INACTIVE_ALPHA);
         this.value.alpha = !!this._model.isValueActive ? Number(Values.DEFAULT_ALPHA) : Number(INACTIVE_ALPHA);
         this.secondValue.alpha = !!this._model.isSecondValueActive ? Number(Values.DEFAULT_ALPHA) : Number(INACTIVE_ALPHA);
         this.rightDashLine.visible = this._isSecondValue;
      }
      
      private function dispatchPersonalCaseEvent() : void
      {
         dispatchEvent(new PersonalCaseEvent(PersonalCaseEvent.CHANGE_TAB_ON_TWO,true));
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._model.imageType == ICON_TYPE_NEW_SKILL)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TANKMAN_NEW_SKILL,TooltipProps.DEFAULT,this._tankmanID);
         }
         else
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TANKMAN_SKILL,null,this._skillName,this._tankmanID);
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         this.dispatchPersonalCaseEvent();
      }
   }
}
