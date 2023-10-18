package net.wg.gui.components.advanced
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Time;
   import net.wg.gui.components.advanced.interfaces.ICooldownSlot;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.CooldownEvent;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class CooldownSlot extends AmmunitionButton implements ICooldownSlot
   {
       
      
      public var iconLoader:UILoaderAlt;
      
      public var cooldownAnimator:CooldownAnimationController;
      
      private var _id:String;
      
      private var _icon:String;
      
      private var _isDischarging:Boolean = false;
      
      private var _isCooolDownInProgress:Boolean = false;
      
      private var _isInactive:Boolean = false;
      
      private var _onlyLeftButton:Boolean = false;
      
      public function CooldownSlot()
      {
         super();
         if(this.cooldownAnimator != null)
         {
            this.cooldownAnimator.visible = false;
            this.cooldownAnimator.addEventListener(CooldownEvent.FINISHED,this.cooldownAnimatorFinishedHandler);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = !!mouseEnabledOnDisabled ? Boolean(true) : Boolean(enabled);
         if(hitMc != null)
         {
            this.hitArea = hitMc;
         }
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         addEventListener(MouseEvent.CLICK,this.onMouseOutHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onMouseOutHandler);
         if(this.cooldownAnimator != null)
         {
            this.cooldownAnimator.removeEventListener(CooldownEvent.FINISHED,this.cooldownAnimatorFinishedHandler);
            this.cooldownAnimator.dispose();
            this.cooldownAnimator = null;
         }
         if(this.iconLoader != null)
         {
            this.iconLoader.dispose();
            this.iconLoader = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.cooldownAnimator != null)
         {
            this.cooldownAnimator.visible = this._isCooolDownInProgress;
         }
      }
      
      public function clear() : void
      {
         this._id = null;
         this.icon = null;
         label = "";
      }
      
      public function clearCoolDownTime() : void
      {
         this._isCooolDownInProgress = false;
         if(this.cooldownAnimator != null)
         {
            this.cooldownAnimator.clearCooldown();
            this.cooldownAnimator.visible = false;
         }
      }
      
      public function setCoolDownPosAsPercent(param1:Number) : void
      {
         if(this.cooldownAnimator != null)
         {
            this.cooldownAnimator.visible = true;
            this.cooldownAnimator.setPositionAsPercent(param1);
         }
         this._isCooolDownInProgress = true;
      }
      
      public function setCooldown(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(this.cooldownAnimator != null)
         {
            this.cooldownAnimator.visible = true;
            if(param1 > 0)
            {
               _loc2_ = param1 * Time.MILLISECOND_IN_SECOND;
               if(this._isCooolDownInProgress)
               {
                  this.cooldownAnimator.restartCooldownFromCurrentProgress(_loc2_);
               }
               else
               {
                  this._isCooolDownInProgress = true;
                  this.cooldownAnimator.startCooldown(_loc2_);
               }
            }
            else
            {
               this.clearCoolDownTime();
            }
         }
      }
      
      protected function onMouseOver() : void
      {
      }
      
      protected function onMouseOut() : void
      {
      }
      
      protected function onCooldownAnimatorFinished() : void
      {
         if(!this._isDischarging)
         {
            if(this.cooldownAnimator != null)
            {
               this.cooldownAnimator.visible = false;
            }
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == enabled)
         {
            return;
         }
         if(this.focusable && this.focused && !param1)
         {
            this.focused = 0;
         }
         super.enabled = param1;
         buttonMode = enabled;
         mouseEnabled = enabled;
      }
      
      public function get displayObject() : DisplayObject
      {
         return this;
      }
      
      [Inspectable(defaultValue="",name="icon")]
      public function get icon() : String
      {
         return this._icon;
      }
      
      public function set icon(param1:String) : void
      {
         this._icon = param1;
         if(this.iconLoader != null)
         {
            this.iconLoader.visible = StringUtils.isNotEmpty(this._icon);
            if(this.iconLoader.visible)
            {
               this.iconLoader.source = this._icon;
            }
         }
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get isDischarging() : Boolean
      {
         return this._isDischarging;
      }
      
      public function set isDischarging(param1:Boolean) : void
      {
         this._isDischarging = param1;
         if(this.cooldownAnimator != null)
         {
            this.cooldownAnimator.isDischarging = this._isDischarging;
         }
      }
      
      public function get isInactive() : Boolean
      {
         return this._isInactive;
      }
      
      public function set isInactive(param1:Boolean) : void
      {
         this._isInactive = param1;
      }
      
      public function get onlyLeftButton() : Boolean
      {
         return this._onlyLeftButton;
      }
      
      public function set onlyLeftButton(param1:Boolean) : void
      {
         this._onlyLeftButton = param1;
      }
      
      public function get isCooolDownInProgress() : Boolean
      {
         return this._isCooolDownInProgress;
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         if(this._onlyLeftButton && !App.utils.commons.isLeftButton(param1))
         {
            return;
         }
         super.handleMousePress(param1);
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         if(this._onlyLeftButton && !App.utils.commons.isLeftButton(param1))
         {
            return;
         }
         super.handleMouseRelease(param1);
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         this.onMouseOver();
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this.onMouseOut();
      }
      
      private function cooldownAnimatorFinishedHandler(param1:CooldownEvent) : void
      {
         this.onCooldownAnimatorFinished();
      }
   }
}
