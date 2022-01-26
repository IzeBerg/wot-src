package net.wg.gui.lobby.personalMissions.components.statusFooter
{
   import flash.text.TextField;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.personalMissions.data.SheetsInfoBlockVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.InvalidationType;
   
   public class SheetsInfoBlock extends UIComponentEx implements IUpdatableComponent
   {
       
      
      public var image:IImage = null;
      
      public var titleTf:TextField = null;
      
      public var descrTf:TextField = null;
      
      private var _data:SheetsInfoBlockVO = null;
      
      public function SheetsInfoBlock()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.image.source = this._data.imgSource;
            this.titleTf.htmlText = this._data.titleText;
            this.descrTf.htmlText = this._data.descrText;
         }
      }
      
      override protected function onDispose() : void
      {
         this.image.dispose();
         this.image = null;
         this.titleTf = null;
         this.descrTf = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         this._data = SheetsInfoBlockVO(param1);
         invalidateData();
      }
   }
}
