package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.data.constants.generated.BLOCKS_TOOLTIP_TYPES;
   import net.wg.data.constants.generated.TEXT_ALIGN;
   import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
   import net.wg.gui.components.common.containers.TiledLayout;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.GroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.components.tooltips.inblocks.data.GroupBlockVO;
   
   public class GroupBlock extends BaseTooltipBlock
   {
      
      private static const GROUP_GAP:uint = 15;
       
      
      public var bounds:Sprite = null;
      
      private var _group:IGroupEx = null;
      
      private var _data:GroupBlockVO = null;
      
      private var _blockWidth:Number = 0;
      
      public function GroupBlock()
      {
         super();
      }
      
      private static function createGroupLayout(param1:int, param2:String) : GroupLayout
      {
         var _loc3_:GroupLayout = null;
         switch(param2)
         {
            case BLOCKS_TOOLTIP_TYPES.ALIGN_LEFT:
               _loc3_ = new TiledLayout(param1,param1,TiledLayout.DEFAULT_COLUMNS_COUNT,TEXT_ALIGN.LEFT);
               break;
            case BLOCKS_TOOLTIP_TYPES.ALIGN_RIGHT:
               _loc3_ = new TiledLayout(param1,param1,TiledLayout.DEFAULT_COLUMNS_COUNT,TEXT_ALIGN.RIGHT);
               break;
            default:
               _loc3_ = new CenterAlignedGroupLayout(param1,param1);
         }
         return _loc3_;
      }
      
      override public function cleanUp() : void
      {
         super.cleanUp();
         this._blockWidth = 0;
      }
      
      override public function getHeight() : Number
      {
         return this.bounds.height;
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new GroupBlockVO(param1);
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         this._blockWidth = param1;
         if(param1 > 0 && this._group != null)
         {
            this._group.width = param1 - this._group.x;
            this._group.invalidateLayout();
         }
      }
      
      override protected function onValidateBlock() : Boolean
      {
         this.applyData();
         return false;
      }
      
      override protected function onDispose() : void
      {
         this.bounds = null;
         if(this._group)
         {
            removeChild(DisplayObject(this._group));
            this._group.dispose();
         }
         this._group = null;
         this.clearData();
         super.onDispose();
      }
      
      private function applyData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:GroupLayout = null;
         if(this._group == null)
         {
            _loc1_ = this._data.rendererWidth;
            _loc2_ = createGroupLayout(_loc1_,this._data.align);
            _loc2_.gap = GROUP_GAP;
            this._group = new GroupEx();
            this._group.width = this._blockWidth - this._group.x;
            this.bounds.x = this._group.x;
            this.bounds.height = _loc1_;
            this.bounds.width = this._group.width;
            this._group.layout = _loc2_;
            this._group.itemRendererLinkage = this._data.rendererType;
            this._group.dataProvider = this._data.iconSrcDP;
            addChild(DisplayObject(this._group));
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
