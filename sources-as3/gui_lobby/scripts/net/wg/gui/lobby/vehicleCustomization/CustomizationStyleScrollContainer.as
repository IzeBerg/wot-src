package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.interfaces.IContentSize;
   import net.wg.gui.lobby.vehicleCustomization.data.styleInfo.StyleInfoVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.data.DataProvider;
   
   public class CustomizationStyleScrollContainer extends Sprite implements IContentSize, IDisposable
   {
      
      private static const PARAM_RENDERERS_GAP:int = 46;
      
      private static const PARAM_RENDERERS_GAP_SMALL:int = 20;
      
      private static const PARAM_RENDERED_WIDTH:int = 110;
      
      private static const STYLE_INFO_TEXT_OFFSET_Y:int = 36;
      
      private static const PARAM_RENDERER_NAME:String = "ParamIconRendererUI";
       
      
      public var paramsBlock:SimpleTileList;
      
      public var styleInfoTf:TextField = null;
      
      public var suitableTf:TextField = null;
      
      private var _styleInfoText:String = "";
      
      private var _styleInfoTextBig:String = "";
      
      private var _disposed:Boolean = false;
      
      public function CustomizationStyleScrollContainer()
      {
         super();
         this.paramsBlock.itemRenderer = App.utils.classFactory.getClass(PARAM_RENDERER_NAME);
         this.paramsBlock.directionMode = DirectionMode.HORIZONTAL;
         this.paramsBlock.tileWidth = PARAM_RENDERED_WIDTH;
         this.styleInfoTf.autoSize = this.suitableTf.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function get contentHeight() : Number
      {
         return this.suitableTf.y + this.suitableTf.height | 0;
      }
      
      public function get contentWidth() : Number
      {
         return width;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         if(this.paramsBlock)
         {
            this.paramsBlock.dispose();
            this.paramsBlock = null;
         }
         this.styleInfoTf = null;
         this.suitableTf = null;
         this._styleInfoText = null;
         this._styleInfoTextBig = null;
      }
      
      public function updateSize(param1:Boolean, param2:Boolean) : void
      {
         this.paramsBlock.horizontalGap = !!param2 ? Number(PARAM_RENDERERS_GAP_SMALL) : Number(PARAM_RENDERERS_GAP);
         this.paramsBlock.border.width = this.styleInfoTf.width = this.suitableTf.width = this.width;
         this.styleInfoTf.htmlText = param1 || param2 ? this._styleInfoText : this._styleInfoTextBig;
         var _loc3_:int = 0;
         var _loc4_:StyleInfoRenderer = null;
         var _loc5_:int = this.paramsBlock.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = StyleInfoRenderer(this.paramsBlock.getRendererAt(_loc6_));
            _loc3_ = Math.max(_loc3_,_loc4_.contentHeight);
            _loc6_++;
         }
         this.styleInfoTf.y = _loc3_ + STYLE_INFO_TEXT_OFFSET_Y;
         this.suitableTf.y = this.styleInfoTf.y + this.styleInfoTf.height;
      }
      
      public function setData(param1:StyleInfoVO) : void
      {
         this._styleInfoText = param1.styleInfo;
         this._styleInfoTextBig = param1.styleInfoBig;
         this.suitableTf.htmlText = param1.suitableBlock;
         this.paramsBlock.dataProvider = new DataProvider(App.utils.data.vectorToArray(param1.styleParams));
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
