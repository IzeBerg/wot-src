package net.wg.gui.lobby.eventBoards.components
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.lobby.eventBoards.data.BasePlayerBattleRendererVO;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.InvalidationType;
   
   public class BasePlayerBattleRenderer extends SoundListItemRenderer
   {
       
      
      public var dateTF:TextField = null;
      
      public var technicsTF:TextField = null;
      
      public var technicsNameTF:TextField = null;
      
      public var resultTF:TextField = null;
      
      public var value1TF:TextField = null;
      
      public var value2TF:TextField = null;
      
      public var value3TF:TextField = null;
      
      public var value4TF:TextField = null;
      
      public var value5TF:TextField = null;
      
      public var value6TF:TextField = null;
      
      public var value7TF:TextField = null;
      
      public var value8TF:TextField = null;
      
      public var icon:IImage = null;
      
      public var vehicle:IImage = null;
      
      private var _rendererData:BasePlayerBattleRendererVO = null;
      
      public function BasePlayerBattleRenderer()
      {
         super();
      }
      
      override public function getData() : Object
      {
         return this._rendererData;
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 != null)
         {
            this._rendererData = BasePlayerBattleRendererVO(param1);
            invalidateData();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         visible = false;
      }
      
      override protected function draw() : void
      {
         if(this._rendererData && isInvalid(InvalidationType.DATA))
         {
            this.dateTF.htmlText = this._rendererData.date;
            this.technicsTF.htmlText = this._rendererData.technics;
            this.technicsTF.alpha = this._rendererData.iconAlpha;
            this.technicsNameTF.htmlText = this._rendererData.technicsName;
            this.resultTF.htmlText = this._rendererData.result;
            this.value1TF.htmlText = App.utils.locale.integer(this._rendererData.value1);
            this.value2TF.htmlText = App.utils.locale.integer(this._rendererData.value2);
            this.value3TF.htmlText = App.utils.locale.integer(this._rendererData.value3);
            this.value4TF.htmlText = App.utils.locale.integer(this._rendererData.value4);
            this.value5TF.htmlText = App.utils.locale.integer(this._rendererData.value1);
            this.value6TF.htmlText = App.utils.locale.integer(this._rendererData.value2);
            this.value7TF.htmlText = App.utils.locale.integer(this._rendererData.value3);
            this.value8TF.htmlText = App.utils.locale.integer(this._rendererData.value4);
            this.value1TF.visible = this._rendererData.isEnable;
            this.value2TF.visible = this._rendererData.isEnable;
            this.value3TF.visible = this._rendererData.isEnable;
            this.value4TF.visible = this._rendererData.isEnable;
            this.value5TF.visible = !this._rendererData.isEnable;
            this.value6TF.visible = !this._rendererData.isEnable;
            this.value7TF.visible = !this._rendererData.isEnable;
            this.value8TF.visible = !this._rendererData.isEnable;
            this.icon.source = this._rendererData.icon;
            this.icon.alpha = this._rendererData.iconAlpha;
            this.vehicle.source = this._rendererData.vehicle;
            this.vehicle.alpha = this._rendererData.iconAlpha;
            visible = true;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.dateTF = null;
         this.technicsTF = null;
         this.technicsNameTF = null;
         this.resultTF = null;
         this.value1TF = null;
         this.value2TF = null;
         this.value3TF = null;
         this.value4TF = null;
         this.value5TF = null;
         this.value6TF = null;
         this.value7TF = null;
         this.value8TF = null;
         this.icon.dispose();
         this.icon = null;
         this.vehicle.dispose();
         this.vehicle = null;
         this._rendererData = null;
         super.onDispose();
      }
   }
}
