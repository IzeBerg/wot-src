package net.wg.gui.lobby.techtree.controls
{
   import net.wg.gui.components.common.containers.TiledLayout;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class BenefitsComponent extends UIComponentEx
   {
      
      private static const BENEFITS_GAP:uint = 15;
      
      private static const COLUMN:uint = 4;
      
      private static const COMPACT_COLUMN:uint = 2;
      
      private static const MINIMAL_RENDERS_TO_COMPACT:uint = 4;
      
      private static const BENEFIT_RENDERER:String = "BenefitRendererUI";
       
      
      private var _premiumGroup:GroupEx = null;
      
      private var _tiledLayout:TiledLayout;
      
      private var _isCompact:Boolean = false;
      
      private var _rendersCount:uint = 0;
      
      public function BenefitsComponent()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._premiumGroup = new GroupEx();
         this._premiumGroup.itemRendererLinkage = BENEFIT_RENDERER;
         this.addChild(this._premiumGroup);
         this._tiledLayout = new TiledLayout(BenefitRenderer.TILE_WIDTH,BenefitRenderer.TILE_HEIGHT,COLUMN);
         this._tiledLayout.gap = BENEFITS_GAP;
         this._premiumGroup.layout = this._tiledLayout;
      }
      
      override protected function onDispose() : void
      {
         this.removeChild(this._premiumGroup);
         this._premiumGroup.dispose();
         this._premiumGroup = null;
         this._tiledLayout.dispose();
         this._tiledLayout = null;
         super.onDispose();
      }
      
      public function setData(param1:IDataProvider) : void
      {
         this._premiumGroup.dataProvider = param1;
         this._rendersCount = param1.length;
      }
      
      override public function get height() : Number
      {
         return this._premiumGroup.height;
      }
      
      override public function get width() : Number
      {
         return this._premiumGroup.width;
      }
      
      public function get compact() : Boolean
      {
         return this._isCompact;
      }
      
      public function set compact(param1:Boolean) : void
      {
         if(this._isCompact != param1)
         {
            this._isCompact = param1 && this._rendersCount >= MINIMAL_RENDERS_TO_COMPACT;
            this._tiledLayout.columns = !!this._isCompact ? uint(COMPACT_COLUMN) : uint(COLUMN);
         }
      }
   }
}
