package net.wg.gui.lobby.personalMissions.components.statusFooter
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.lobby.components.ArrowDown;
   import net.wg.gui.lobby.personalMissions.data.SheetsBlockVO;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import scaleform.clik.constants.InvalidationType;
   
   public class SheetsBlock extends BasicFooterBlock implements ISoundable
   {
       
      
      public var freeSheetsTf:TextField = null;
      
      public var pawnedSheetsTf:TextField = null;
      
      public var arrow:ArrowDown = null;
      
      public var separator2:Sprite = null;
      
      private var _data:SheetsBlockVO = null;
      
      public function SheetsBlock()
      {
         super();
      }
      
      override public function onPopoverClose() : void
      {
         this.arrow.state = ArrowDown.STATE_UP;
      }
      
      override public function onPopoverOpen() : void
      {
         this.arrow.state = ArrowDown.STATE_NORMAL;
      }
      
      override public function update(param1:Object) : void
      {
         this._data = SheetsBlockVO(param1);
         super.update(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.soundMgr.addSoundsHdlrs(this);
         this.arrow.state = ArrowDown.STATE_UP;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.freeSheetsTf.htmlText = this._data.freeSheetsText;
            this.pawnedSheetsTf.htmlText = this._data.pawnedSheetsText;
            icon.source = this._data.freeSheetsIcon;
            invalidateSize();
         }
      }
      
      override protected function onDispose() : void
      {
         this.arrow.dispose();
         this.arrow = null;
         this.freeSheetsTf = null;
         this.pawnedSheetsTf = null;
         this.separator2 = null;
         this._data = null;
         super.onDispose();
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return true;
      }
      
      public function getSoundId() : String
      {
         return "";
      }
      
      public function getSoundType() : String
      {
         return SoundTypes.SHEETS_POPOVER;
      }
   }
}
