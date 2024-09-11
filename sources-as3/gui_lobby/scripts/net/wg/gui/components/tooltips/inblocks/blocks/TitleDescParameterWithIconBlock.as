package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.PaddingVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.tooltips.inblocks.data.TitleDescParameterWithIconVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class TitleDescParameterWithIconBlock extends AbstractTextParameterBlock
   {
       
      
      public var titleTF:TextField;
      
      public var image:Image = null;
      
      private var _isDataApplied:Boolean = false;
      
      public function TitleDescParameterWithIconBlock()
      {
         super();
         this.titleTF.autoSize = valueTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override public function cleanUp() : void
      {
         clearData();
         this.titleTF.x = this.titleTF.y = valueTF.x = valueTF.y = 0;
         this.titleTF.text = this.titleTF.htmlText = valueTF.text = valueTF.htmlText = null;
         this.image.x = this.image.y = 0;
      }
      
      override public function setBlockData(param1:Object) : void
      {
         clearData();
         _data = new TitleDescParameterWithIconVO(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override protected function getDataClass() : Class
      {
         return TitleDescParameterWithIconVO;
      }
      
      override protected function onDispose() : void
      {
         this.cleanUp();
         this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.image.dispose();
         this.image = null;
         this.titleTF = null;
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            this.applyData();
            this.invalidateSize();
            return true;
         }
         return false;
      }
      
      private function invalidateSize() : void
      {
         var _loc1_:TitleDescParameterWithIconVO = null;
         _loc1_ = TitleDescParameterWithIconVO(_data);
         var _loc2_:TextField = valueTF;
         var _loc3_:TextField = this.titleTF;
         var _loc4_:PaddingVO = _loc1_.valuePadding;
         var _loc5_:PaddingVO = _loc1_.titlePadding;
         if(_loc1_.valueAtRight)
         {
            _loc2_ = this.titleTF;
            _loc3_ = valueTF;
            _loc4_ = _loc1_.titlePadding;
            _loc5_ = _loc1_.valuePadding;
            _loc2_.x = 0;
         }
         else
         {
            valueTF.autoSize = TextFieldAutoSize.RIGHT;
            _loc2_.x = -_loc2_.width;
         }
         _loc2_.y = 0;
         this.setPaddings(_loc2_,_loc4_);
         var _loc6_:int = _loc2_.x + _loc2_.width ^ 0;
         if(this.image.visible)
         {
            this.image.x = _loc6_;
            this.image.y = 0;
            this.image.alpha = _loc1_.iconAlpha;
            this.setPaddings(this.image,_loc1_.iconPadding);
            _loc6_ = this.image.x + this.image.width ^ 0;
         }
         _loc3_.x = _loc6_;
         _loc3_.y = 0;
         this.setPaddings(_loc3_,_loc5_);
      }
      
      private function setPaddings(param1:DisplayObject, param2:PaddingVO) : void
      {
         if(param2 != null)
         {
            param1.x += param2.left - param2.right;
            param1.y += param2.top - param2.bottom;
         }
      }
      
      private function applyData() : void
      {
         App.utils.asserter.assertNotNull(_data,"_data " + Errors.CANT_NULL);
         var _loc1_:TitleDescParameterWithIconVO = TitleDescParameterWithIconVO(_data);
         if(_loc1_.titleWidth != Values.DEFAULT_INT)
         {
            this.titleTF.autoSize = TextFieldAutoSize.NONE;
            this.titleTF.wordWrap = true;
            this.titleTF.width = _loc1_.titleWidth;
         }
         this.applyTextData(this.titleTF,_loc1_.name);
         this.applyTextData(valueTF,_loc1_.value);
         this.image.visible = StringUtils.isNotEmpty(_loc1_.icon);
         if(this.image.visible)
         {
            this.image.source = _loc1_.icon;
            this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         }
         this._isDataApplied = true;
      }
      
      private function applyTextData(param1:TextField, param2:String) : void
      {
         if(param1 != null)
         {
            param1.visible = StringUtils.isNotEmpty(param2);
            if(param1.visible)
            {
               param1.htmlText = param2;
               App.utils.commons.updateTextFieldSize(param1,false,true);
            }
         }
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         this.invalidateSize();
      }
   }
}
