package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.battleResults.data.VehicleItemVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class TankResultItemRenderer extends SoundListItemRenderer
   {
       
      
      public var clickArea:MovieClip = null;
      
      public var titleLbl:TextField = null;
      
      public var vIconLoader:UILoaderAlt = null;
      
      private var _dataVO:VehicleItemVO = null;
      
      public function TankResultItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         if(param1 != null)
         {
            this._dataVO = param1 as VehicleItemVO;
            invalidateData();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         hitArea = this.clickArea;
      }
      
      override protected function onDispose() : void
      {
         this.clickArea = null;
         this.titleLbl = null;
         this.vIconLoader.dispose();
         this.vIconLoader = null;
         if(this._dataVO)
         {
            this._dataVO.dispose();
            this._dataVO = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._dataVO != null)
         {
            visible = true;
            this.titleLbl.text = this._dataVO.label;
            this.vIconLoader.hideLoader = true;
            this.vIconLoader.source = this._dataVO.icon;
         }
         else
         {
            visible = false;
         }
      }
      
      override protected function updateAfterStateChange() : void
      {
         super.updateAfterStateChange();
         invalidateData();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = param1;
      }
   }
}
