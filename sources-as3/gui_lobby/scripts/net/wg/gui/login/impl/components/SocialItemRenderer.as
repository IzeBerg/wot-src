package net.wg.gui.login.impl.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.login.impl.vo.SocialIconVo;
   import net.wg.infrastructure.managers.ITooltipFormatter;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class SocialItemRenderer extends ListItemRenderer
   {
      
      private static const FILE_EXTENSION:String = ".png";
      
      private static const OVER_ALPHA:Number = 0.7;
      
      private static const NORMAL_ALPHA:int = 1;
       
      
      public var icon:UILoaderAlt = null;
      
      public var hitMc:Sprite = null;
      
      private var _rendererData:SocialIconVo = null;
      
      public function SocialItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         this.data = param1;
         this._rendererData = SocialIconVo(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hitArea = this.hitMc;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && data)
         {
            if(this._rendererData.socialId)
            {
               this.icon.visible = true;
               this.icon.source = RES_ICONS.maps_icons_buttons_social_color(this._rendererData.socialId + FILE_EXTENSION);
            }
            else
            {
               this.icon.visible = false;
               this.icon.source = "";
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._rendererData = null;
         this.hitMc = null;
         this.icon.dispose();
         this.icon = null;
         super.onDispose();
      }
      
      private function showTooltip() : void
      {
         var _loc1_:ITooltipFormatter = App.toolTipMgr.getNewFormatter();
         _loc1_.addHeader(this._rendererData.tpHeader);
         _loc1_.addBody(this._rendererData.tpBody);
         App.toolTipMgr.showComplex(_loc1_.make());
      }
      
      private function hideTooltip() : void
      {
         App.toolTipMgr.hide();
      }
      
      public function get socialId() : String
      {
         return this._rendererData.socialId;
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.showTooltip();
         this.alpha = OVER_ALPHA;
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this.hideTooltip();
         this.alpha = NORMAL_ALPHA;
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         super.handleMousePress(param1);
         this.hideTooltip();
         this.alpha = OVER_ALPHA;
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         super.handleMouseRelease(param1);
         this.alpha = NORMAL_ALPHA;
      }
      
      override protected function handleReleaseOutside(param1:MouseEvent) : void
      {
         super.handleReleaseOutside(param1);
         this.alpha = NORMAL_ALPHA;
      }
   }
}
