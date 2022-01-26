package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.inblocks.data.BadgeInfoBlockVO;
   import net.wg.infrastructure.interfaces.IImage;
   
   public class BadgeInfoBlock extends BaseTooltipBlock
   {
       
      
      public var badgeImg:IImage = null;
      
      public var vehImg:IImage = null;
      
      public var playerNameTf:TextField = null;
      
      public var vehNameTf:TextField = null;
      
      private var _data:BadgeInfoBlockVO;
      
      private var _isDataApplied:Boolean = false;
      
      public function BadgeInfoBlock()
      {
         super();
      }
      
      override public function cleanUp() : void
      {
         this.clearData();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new BadgeInfoBlockVO(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.cleanUp();
         this.badgeImg.dispose();
         this.badgeImg = null;
         this.vehImg.dispose();
         this.vehImg = null;
         this.playerNameTf = null;
         this.vehNameTf = null;
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            this.applyData();
            return true;
         }
         return false;
      }
      
      private function applyData() : void
      {
         this.badgeImg.source = this._data.badgeImgSource;
         this.vehImg.source = this._data.vehImgSource;
         App.utils.commons.truncateHtmlTextMultiline(this.playerNameTf,this._data.playerName);
         this.vehNameTf.htmlText = this._data.vehName;
         this._isDataApplied = true;
      }
      
      private function clearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
   }
}
