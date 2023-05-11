package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.inblocks.data.BadgeInfoBlockVO;
   import net.wg.infrastructure.interfaces.IImage;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class BadgeInfoBlock extends BaseTooltipBlock
   {
      
      private static const BADGE_IMG_NORMAL_X:int = 5;
      
      private static const PLAYER_NAME_NORMAL_X:int = 33;
      
      private static const PLAYER_NAME_SUFFIX_X:int = 5;
      
      private static const BADGE_IMG_SUFFIX_X_SHIFT:int = 10;
      
      private static const STRIP_IMG_SUFFIX_X_SHIFT:int = -56;
       
      
      public var badgeImg:IImage = null;
      
      public var vehImg:IImage = null;
      
      public var playerNameTf:TextField = null;
      
      public var vehNameTf:TextField = null;
      
      public var stripImg:IImage = null;
      
      private var _data:BadgeInfoBlockVO;
      
      private var _isDataApplied:Boolean = false;
      
      private var _isSuffixLayout:Boolean = false;
      
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
         this.stripImg.dispose();
         this.stripImg = null;
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
         this._isSuffixLayout = StringUtils.isNotEmpty(this._data.stripImgSource);
         this.stripImg.visible = this._isSuffixLayout;
         if(this._isSuffixLayout)
         {
            this.stripImg.source = this._data.stripImgSource;
         }
         this.updateLayout();
         this._isDataApplied = true;
      }
      
      private function updateLayout() : void
      {
         if(this._isSuffixLayout)
         {
            this.playerNameTf.x = PLAYER_NAME_SUFFIX_X;
            this.badgeImg.x = this.playerNameTf.x + this.playerNameTf.textWidth + BADGE_IMG_SUFFIX_X_SHIFT | 0;
            this.stripImg.x = this.badgeImg.x + STRIP_IMG_SUFFIX_X_SHIFT;
         }
         else
         {
            this.badgeImg.x = BADGE_IMG_NORMAL_X;
            this.playerNameTf.x = PLAYER_NAME_NORMAL_X;
         }
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
