package net.wg.gui.lobby.personalMissions.components.popupComponents
{
   import net.wg.gui.lobby.personalMissions.data.FourFreeSheetsObtainedPopupVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class FourFreeSheetsObtainedPopup extends AbstractFreeSheetPopup
   {
      
      private static const HIDE_FRAME_IND:int = 131;
       
      
      public var header:HeaderBlock;
      
      public var icon0:IconTextRenderer;
      
      public var icon1:IconTextRenderer;
      
      public var icon2:IconTextRenderer;
      
      private var _vo:FourFreeSheetsObtainedPopupVO;
      
      public function FourFreeSheetsObtainedPopup()
      {
         super();
      }
      
      override public function init(param1:Boolean, param2:Object) : void
      {
         super.init(param1,param2);
         if(param2 != null)
         {
            this._vo = new FourFreeSheetsObtainedPopupVO(param2);
            invalidateData();
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._vo && isInvalid(InvalidationType.DATA))
         {
            this.icon0.setData(this._vo.icon0);
            this.icon1.setData(this._vo.icon1);
            this.icon2.setData(this._vo.icon2);
            this.header.setText(this._vo.header);
            BottomBlock(bottomBlock).setDescription(this._vo.description);
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon0.dispose();
         this.icon0 = null;
         this.icon1.dispose();
         this.icon1 = null;
         this.icon2.dispose();
         this.icon2 = null;
         this.header.dispose();
         this.header = null;
         this._vo.dispose();
         this._vo = null;
         super.onDispose();
      }
      
      override protected function get hideFrameInd() : int
      {
         return HIDE_FRAME_IND;
      }
   }
}
