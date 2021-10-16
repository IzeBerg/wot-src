package net.wg.gui.battle.battleRoyale.views.components.tooltips.inblocks.blocks
{
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.gui.battle.battleRoyale.views.components.VehicleWeakZonesCmp;
   import net.wg.gui.battle.battleRoyale.views.components.tooltips.inblocks.data.BattleRoyaleWeakZonesBlockVO;
   import net.wg.gui.components.tooltips.inblocks.blocks.BaseTooltipBlock;
   import net.wg.utils.ICommons;
   
   public class BattleRoyaleWeakZonesBlock extends BaseTooltipBlock
   {
      
      private static const TITLE_DESCRIPTION_GAP:int = 4;
      
      private static const WEAK_ZONES_CMP_OFFSET_Y:int = 12;
       
      
      public var titleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var weakZonesCmp:VehicleWeakZonesCmp = null;
      
      private var _data:BattleRoyaleWeakZonesBlockVO = null;
      
      private var _commons:ICommons;
      
      private var _blockWidth:int = 0;
      
      private var _isDataApplied:Boolean = false;
      
      public function BattleRoyaleWeakZonesBlock()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override public function cleanUp() : void
      {
         this.cleanData();
         this.titleTF.text = this.descriptionTF.text = null;
         this.weakZonesCmp.cleanUp();
      }
      
      override public function getWidth() : Number
      {
         return this.weakZonesCmp.width > this._blockWidth ? Number(this.weakZonesCmp.width) : Number(this._blockWidth);
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         this._blockWidth = param1;
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.cleanData();
         this._data = new BattleRoyaleWeakZonesBlockVO(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override protected function onDispose() : void
      {
         this.cleanData();
         this.titleTF = null;
         this.descriptionTF = null;
         this.weakZonesCmp.dispose();
         this.weakZonesCmp = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            this.applyData();
            return true;
         }
         this.layout();
         return false;
      }
      
      protected function applyData() : void
      {
         this.titleTF.htmlText = this._data.title;
         this.descriptionTF.htmlText = this._data.description;
         this.weakZonesCmp.setData(this._data);
         this._isDataApplied = true;
      }
      
      private function layout() : void
      {
         this.titleTF.width = this.descriptionTF.width = this.getWidth();
         this._commons.updateTextFieldSize(this.titleTF,false,true);
         this.descriptionTF.y = this.titleTF.y + this.titleTF.height + TITLE_DESCRIPTION_GAP;
         this._commons.updateTextFieldSize(this.descriptionTF,false,true);
         var _loc1_:Rectangle = this.weakZonesCmp.getBounds(this.weakZonesCmp);
         var _loc2_:Number = this.getWidth();
         this.weakZonesCmp.x = -_loc1_.x + (_loc2_ - _loc1_.width >> 1);
         this.weakZonesCmp.y = this.descriptionTF.y + this.descriptionTF.height - _loc1_.y + WEAK_ZONES_CMP_OFFSET_Y;
      }
      
      private function cleanData() : void
      {
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
      }
   }
}
