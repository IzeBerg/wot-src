package net.wg.gui.lobby.components
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.components.events.ShineEvent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ButtonNormalShine extends SoundButtonEx
   {
      
      private static const DEF_BTN_WIDTH:int = 160;
       
      
      private var _shineAnim:ButtonNormalShineAnim = null;
      
      private var _tooltipSpecialID:String = "";
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _shineDefWidth:int = 0;
      
      public function ButtonNormalShine()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this._tooltipMgr = null;
         this.clearShine();
         super.onDispose();
      }
      
      override protected function showTooltip() : void
      {
         if(StringUtils.isNotEmpty(this._tooltipSpecialID))
         {
            this._tooltipMgr.showSpecial(this._tooltipSpecialID,null);
         }
         else
         {
            super.showTooltip();
         }
      }
      
      public function shine(param1:Boolean, param2:int = 0) : void
      {
         if(!this.stage)
         {
            return;
         }
         if(!this._shineAnim)
         {
            this._shineAnim = App.utils.classFactory.getComponent(ButtonNormalShineAnim.SHINE_LINKAGE,ButtonNormalShineAnim);
            this._shineAnim.addEventListener(ShineEvent.ON_ANIM_COMPLETED,this.onShineCompletedHandler);
            this._shineDefWidth = this._shineAnim.width;
            this.updateShinePos();
            this.parent.addChildAt(this._shineAnim,this.parent.getChildIndex(this) + 1);
         }
         this._shineAnim.shine(param1,param2);
      }
      
      public function stopShine() : void
      {
         this.clearShine();
      }
      
      private function clearShine() : void
      {
         if(this._shineAnim)
         {
            this._shineAnim.removeEventListener(ShineEvent.ON_ANIM_COMPLETED,this.onShineCompletedHandler);
            this._shineAnim.dispose();
            this.parent.removeChild(this._shineAnim);
            this._shineAnim = null;
         }
      }
      
      private function updateShinePos() : void
      {
         if(!this._shineAnim)
         {
            return;
         }
         this._shineAnim.width = this._shineDefWidth - (DEF_BTN_WIDTH - this.width);
         this._shineAnim.x = this.x + (this.width >> 1);
         this._shineAnim.y = this.y + (this.height >> 1);
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
         this.updateShinePos();
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
         this.updateShinePos();
      }
      
      public function set tooltipSpecialID(param1:String) : void
      {
         this._tooltipSpecialID = param1;
      }
      
      private function onShineCompletedHandler(param1:ShineEvent) : void
      {
         this.clearShine();
      }
   }
}
