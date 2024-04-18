package net.wg.gui.lobby.components
{
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.components.data.RoleVO;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class RoleItemRenderer extends ListItemRenderer
   {
      
      private static const VISIBLE_RENDERERS_COUNT:int = 1;
      
      private static const ALPHA_FULL:int = 1;
      
      private static const ALPHA_HALF:Number = 0.5;
       
      
      public var loader:UILoaderAlt;
      
      private var _roleData:RoleVO = null;
      
      public function RoleItemRenderer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this.loader != null)
         {
            this.loader.dispose();
            this.loader = null;
         }
         this._roleData = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._roleData)
         {
            if(StringUtils.isNotEmpty(this._roleData.icon))
            {
               this.loader.source = this._roleData.icon;
            }
            this.loader.alpha = this._roleData.index < VISIBLE_RENDERERS_COUNT ? Number(ALPHA_FULL) : Number(ALPHA_HALF);
         }
      }
      
      override public function setData(param1:Object) : void
      {
         this.data = param1;
         this._roleData = RoleVO(param1);
         if(this._roleData != null)
         {
            invalidateData();
         }
      }
   }
}
