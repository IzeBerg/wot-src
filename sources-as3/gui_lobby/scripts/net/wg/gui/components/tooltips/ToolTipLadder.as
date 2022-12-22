package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.VO.LadderVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ToolTipLadder extends ToolTipSpecial
   {
      
      private static const ICO_DIMENSION:int = 256;
      
      private static const ICO_TOP_SHIFT:int = 50;
      
      private static const ICO_BOTTOM_SHIFT:int = 29;
      
      private static const MIN_WIDTH:int = 320;
      
      private static const STATE_GAP:int = 5;
      
      private static const BOTTOM:int = 3;
       
      
      public var statusTF:TextField = null;
      
      private var headerTF:TextField = null;
      
      private var icon:UILoaderAlt = null;
      
      private var placeTF:TextField = null;
      
      private var stateTF:TextField = null;
      
      private var seasonTF:TextField = null;
      
      private var pointsTF:TextField = null;
      
      private var whiteBg:Sprite = null;
      
      public function ToolTipLadder()
      {
         super();
         this.headerTF = content.headerTF;
         this.whiteBg = content.whiteBg;
         this.statusTF = content.statusTF;
         this.seasonTF = content.seasonTF;
         this.icon = content.icon;
         this.placeTF = content.placeTF;
         this.stateTF = content.stateTF;
         this.pointsTF = content.pointsTF;
      }
      
      override public function build(param1:Object, param2:ITooltipProps) : void
      {
         super.build(param1,param2);
      }
      
      override public function toString() : String
      {
         return "[WG ToolTipLadder " + name + "]";
      }
      
      override protected function onDispose() : void
      {
         this.headerTF = null;
         this.whiteBg = null;
         this.statusTF = null;
         this.seasonTF = null;
         this.icon.dispose();
         this.icon = null;
         this.placeTF = null;
         this.stateTF = null;
         this.pointsTF = null;
         super.onDispose();
      }
      
      override protected function redraw() : void
      {
         var _loc1_:ICommons = null;
         var _loc2_:Number = NaN;
         var _loc3_:LadderVO = null;
         var _loc4_:Number = NaN;
         _loc1_ = App.utils.commons;
         this.whiteBg.visible = false;
         _loc2_ = MIN_WIDTH;
         separators = new Vector.<Separator>();
         _loc3_ = new LadderVO(_data);
         topPosition = bgShadowMargin.top + contentMargin.top | 0;
         _loc4_ = bgShadowMargin.left + contentMargin.left;
         var _loc5_:Number = bgShadowMargin.horizontal + contentMargin.horizontal;
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.htmlText = _loc3_.name;
         _loc1_.updateTextFieldSize(this.headerTF);
         this.headerTF.x = _loc4_;
         this.headerTF.y = topPosition;
         topPosition += this.headerTF.height + Utils.instance.MARGIN_AFTER_BLOCK | 0;
         _loc2_ = Math.max(_loc2_,this.headerTF.width + _loc5_);
         var _loc6_:Separator = Utils.instance.createSeparate(content);
         _loc6_.y = topPosition;
         separators.push(_loc6_);
         topPosition += Utils.instance.MARGIN_AFTER_SEPARATE | 0;
         this.icon.autoSize = false;
         this.icon.source = _loc3_.icon;
         this.icon.x = _loc4_;
         this.icon.y = topPosition - ICO_TOP_SHIFT | 0;
         topPosition += ICO_DIMENSION - ICO_TOP_SHIFT - ICO_BOTTOM_SHIFT + Utils.instance.MARGIN_AFTER_BLOCK | 0;
         _loc2_ = Math.max(_loc2_,ICO_DIMENSION + _loc5_);
         this.placeTF.autoSize = TextFieldAutoSize.LEFT;
         this.placeTF.htmlText = _loc3_.place;
         _loc1_.updateTextFieldSize(this.placeTF);
         this.placeTF.x = _loc4_;
         this.placeTF.y = topPosition;
         topPosition += this.placeTF.height | 0;
         _loc2_ = Math.max(_loc2_,this.placeTF.width + _loc5_);
         if(StringUtils.isNotEmpty(_loc3_.state))
         {
            topPosition += STATE_GAP;
            this.stateTF.autoSize = TextFieldAutoSize.LEFT;
            this.stateTF.htmlText = _loc3_.state;
            _loc1_.updateTextFieldSize(this.stateTF);
            this.stateTF.x = _loc4_;
            this.stateTF.y = topPosition;
            topPosition += this.stateTF.height | 0;
            _loc2_ = Math.max(_loc2_,this.stateTF.width + _loc5_);
         }
         else
         {
            this.stateTF.visible = false;
         }
         if(StringUtils.isNotEmpty(_loc3_.points))
         {
            this.pointsTF.autoSize = TextFieldAutoSize.LEFT;
            this.pointsTF.htmlText = _loc3_.points;
            _loc1_.updateTextFieldSize(this.pointsTF);
            this.pointsTF.x = _loc4_;
            this.pointsTF.y = topPosition;
            topPosition += this.pointsTF.height | 0;
            _loc2_ = Math.max(_loc2_,this.pointsTF.width + _loc5_);
         }
         else
         {
            this.pointsTF.visible = false;
         }
         topPosition += Utils.instance.MARGIN_AFTER_BLOCK | 0;
         var _loc7_:Boolean = StringUtils.isNotEmpty(_loc3_.season);
         if(StringUtils.isNotEmpty(_loc3_.status))
         {
            _loc6_ = Utils.instance.createSeparate(content);
            _loc6_.y = topPosition;
            separators.push(_loc6_);
            this.whiteBg.y = topPosition;
            this.whiteBg.x = bgShadowMargin.left + 1;
            this.whiteBg.visible = true;
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE | 0;
            this.statusTF.autoSize = TextFieldAutoSize.LEFT;
            this.statusTF.htmlText = _loc3_.status;
            this.statusTF.width = _loc2_ - _loc4_;
            _loc1_.updateTextFieldSize(this.pointsTF,false);
            this.statusTF.x = _loc4_;
            this.statusTF.y = topPosition;
            topPosition += this.statusTF.height + Utils.instance.MARGIN_AFTER_SEPARATE | 0;
            this.whiteBg.height = topPosition - this.whiteBg.y;
            contentMargin.bottom = !!_loc7_ ? Number(contentMargin.bottom) : Number(BOTTOM);
         }
         else
         {
            this.statusTF.visible = false;
         }
         if(_loc7_)
         {
            _loc6_ = Utils.instance.createSeparate(content);
            _loc6_.y = topPosition;
            separators.push(_loc6_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE | 0;
            this.seasonTF.autoSize = TextFieldAutoSize.LEFT;
            this.seasonTF.htmlText = _loc3_.season;
            this.seasonTF.width = _loc2_ - _loc4_;
            this.seasonTF.x = _loc4_;
            this.seasonTF.y = topPosition;
            topPosition += this.seasonTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
         }
         else
         {
            this.seasonTF.visible = false;
         }
         _loc3_.dispose();
         _loc3_ = null;
         this.updatePositions();
         super.redraw();
      }
      
      override protected function updatePositions() : void
      {
         super.updatePositions();
         var _loc1_:Number = content.width + contentMargin.right + bgShadowMargin.right;
         this.icon.x = _loc1_ - ICO_DIMENSION >> 1;
         this.placeTF.x = _loc1_ - this.placeTF.width >> 1;
         this.stateTF.x = _loc1_ - this.stateTF.width >> 1;
         this.pointsTF.x = _loc1_ - this.pointsTF.width >> 1;
      }
      
      override protected function updateSize() : void
      {
         super.updateSize();
         this.whiteBg.width = content.width + bgShadowMargin.horizontal;
      }
   }
}
