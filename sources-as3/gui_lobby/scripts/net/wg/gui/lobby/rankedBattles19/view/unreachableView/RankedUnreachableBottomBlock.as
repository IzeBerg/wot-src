package net.wg.gui.lobby.rankedBattles19.view.unreachableView
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.lobby.rankedBattles19.data.RuleVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankedUnreachableBottomBlock extends UIComponentEx
   {
       
      
      public var rule0:RuleRenderer = null;
      
      public var rule1:RuleRenderer = null;
      
      public var rule2:RuleRenderer = null;
      
      public var bottomTF:TextField = null;
      
      public var bg:Sprite = null;
      
      private var _renderers:Vector.<RuleRenderer> = null;
      
      private var _renderersNum:int = -1;
      
      private var _rulesData:Vector.<RuleVO> = null;
      
      public function RankedUnreachableBottomBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.rule0.dispose();
         this.rule0 = null;
         this.rule1.dispose();
         this.rule1 = null;
         this.rule2.dispose();
         this.rule2 = null;
         this.bottomTF = null;
         this._renderers.splice(0,this._renderersNum);
         this._renderers = null;
         this._rulesData = null;
         this.bg = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bottomTF.autoSize = TextFieldAutoSize.CENTER;
         this._renderers = new <RuleRenderer>[this.rule0,this.rule1,this.rule2];
         this._renderersNum = this._renderers.length;
      }
      
      override protected function draw() : void
      {
         var _loc1_:RuleVO = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc2_ = Boolean(this._rulesData) ? int(this._rulesData.length) : int(0);
            _loc3_ = 0;
            while(_loc3_ < this._renderersNum)
            {
               _loc1_ = _loc3_ < _loc2_ ? this._rulesData[_loc3_] : null;
               this._renderers[_loc3_].setData(_loc1_);
               _loc3_++;
            }
         }
      }
      
      public function setRules(param1:Vector.<RuleVO>) : void
      {
         this._rulesData = param1;
         invalidateData();
      }
   }
}
