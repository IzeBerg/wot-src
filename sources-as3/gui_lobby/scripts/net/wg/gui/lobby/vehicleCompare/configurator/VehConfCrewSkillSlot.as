package net.wg.gui.lobby.vehicleCompare.configurator
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.vehicleCompare.data.VehConfSkillVO;
   import net.wg.gui.lobby.vehicleCompare.events.VehConfSkillEvent;
   import net.wg.gui.utils.ExcludeTweenManager;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehConfCrewSkillSlot extends SoundButtonEx implements IUpdatable
   {
      
      private static const BG_ROLL_OVER_ALPHA:Number = 0.07;
      
      private static const BG_ROLL_OUT_ALPHA:Number = 0.03;
      
      private static const ICON_ROLL_OVER_ALPHA:Number = 1;
      
      private static const ICON_ROLL_OUT_ALPHA:Number = 0.8;
      
      private static const ROLE_ICON_ROLL_OVER_ALPHA:Number = 0.8;
      
      private static const ROLE_ICON_ROLL_OUT_ALPHA:Number = 0.3;
      
      private static const TWEEN_DURATION:Number = 150;
      
      private static const SKILL_LEVEL_ZERO:int = 0;
      
      private static const TOGGLE_ON:String = "on";
      
      private static const TOGGLE_OFF:String = "off";
       
      
      public var toggleIndicator:MovieClip;
      
      public var icon:UILoaderAlt;
      
      public var skillRoleIcon:UILoaderAlt;
      
      public var glow:DisplayObject;
      
      public var bg:DisplayObject;
      
      private var _tweenManager:ExcludeTweenManager;
      
      private var _vo:VehConfSkillVO;
      
      private var _slotIndex:int = -1;
      
      public function VehConfCrewSkillSlot()
      {
         this._tweenManager = new ExcludeTweenManager();
         super();
      }
      
      override protected function changeFocus() : void
      {
         if(focused)
         {
            this.applyAlpha(BG_ROLL_OVER_ALPHA,ICON_ROLL_OVER_ALPHA,ROLE_ICON_ROLL_OVER_ALPHA);
         }
         else if(!selected)
         {
            this.applyAlpha(BG_ROLL_OUT_ALPHA,ICON_ROLL_OUT_ALPHA,ROLE_ICON_ROLL_OUT_ALPHA);
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this._tweenManager.unregisterAll();
         this._tweenManager.dispose();
         this._tweenManager = null;
         this.toggleIndicator = null;
         this.glow = null;
         this.bg = null;
         this.icon.dispose();
         this.icon = null;
         this._vo = null;
         this.skillRoleIcon.dispose();
         this.skillRoleIcon = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         toggle = true;
         allowDeselect = true;
         this.glow.visible = false;
         this.toggleIndicator.gotoAndStop(TOGGLE_OFF);
         this.applyAlpha(BG_ROLL_OUT_ALPHA,ICON_ROLL_OUT_ALPHA,ROLE_ICON_ROLL_OUT_ALPHA,true);
         addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._vo && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._vo.icon;
            this.selected = this._vo.selected;
            this.skillRoleIcon.source = RES_ICONS.getPerkRoleIcon(this._vo.skillRole);
         }
      }
      
      public function update(param1:Object) : void
      {
         this._vo = VehConfSkillVO(param1);
         invalidateData();
      }
      
      private function applyAlpha(param1:Number, param2:Number, param3:Number, param4:Boolean = false) : void
      {
         this._tweenManager.unregisterAll();
         var _loc5_:Number = !!param4 ? Number(0.1) : Number(TWEEN_DURATION);
         this._tweenManager.registerAndLaunch(_loc5_,this.bg,{"alpha":param1},{});
         this._tweenManager.registerAndLaunch(_loc5_,this.icon,{"alpha":param2},{});
         this._tweenManager.registerAndLaunch(_loc5_,this.skillRoleIcon,{"alpha":param3},{});
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         super.selected = param1;
         this.glow.visible = selected;
         this.toggleIndicator.gotoAndStop(!!selected ? TOGGLE_ON : TOGGLE_OFF);
         if(selected)
         {
            this.applyAlpha(BG_ROLL_OVER_ALPHA,ICON_ROLL_OVER_ALPHA,ROLE_ICON_ROLL_OVER_ALPHA);
         }
         else
         {
            this.applyAlpha(BG_ROLL_OUT_ALPHA,ICON_ROLL_OUT_ALPHA,ROLE_ICON_ROLL_OUT_ALPHA);
         }
      }
      
      public function get skillRole() : String
      {
         return this._vo.skillRole;
      }
      
      public function set slotIndex(param1:int) : void
      {
         this._slotIndex = param1;
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
         if(!selected)
         {
            this.applyAlpha(BG_ROLL_OUT_ALPHA,ICON_ROLL_OUT_ALPHA,ROLE_ICON_ROLL_OUT_ALPHA);
         }
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         var _loc2_:Number = !!selected ? Number(this._vo.skillLevel) : Number(SKILL_LEVEL_ZERO);
         App.toolTipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.CREW_PERK_GF,this._vo.skillType,null,_loc2_,true);
         if(!selected)
         {
            this.applyAlpha(BG_ROLL_OVER_ALPHA,ICON_ROLL_OVER_ALPHA,ROLE_ICON_ROLL_OVER_ALPHA);
         }
      }
      
      private function onButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new VehConfSkillEvent(VehConfSkillEvent.SKILL_SELECT,this._vo.skillType,this._slotIndex,selected,true));
      }
   }
}
