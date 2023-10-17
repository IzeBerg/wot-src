package net.wg.gui.lobby.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.components.data.BoosterSlotVO;
   import net.wg.gui.lobby.components.interfaces.IBoosterSlot;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class BoosterSlot extends BaseBoosterSlot implements IBoosterSlot
   {
       
      
      public var timeLeftTf:TextField;
      
      public var countTF:TextField = null;
      
      public var countBg:Sprite = null;
      
      public var qualityIcon:UILoaderAlt = null;
      
      private var _originalTfWidth:Number;
      
      public function BoosterSlot()
      {
         super();
         addOffsettedItems(this.countBg,this.countTF,this.qualityIcon,iconLoader,cooldownAnimator);
         this._originalTfWidth = this.timeLeftTf.width;
      }
      
      override public function update(param1:Object) : void
      {
         var _loc2_:BoosterSlotVO = null;
         var _loc3_:Boolean = false;
         super.update(param1);
         if(param1 != null)
         {
            _loc2_ = BoosterSlotVO(param1);
            _loc3_ = StringUtils.isNotEmpty(_loc2_.qualityIconSrc);
            this.qualityIcon.visible = _loc3_;
            if(_loc3_)
            {
               this.qualityIcon.source = _loc2_.qualityIconSrc;
            }
            this.timeLeftTf.visible = _loc2_.showLeftTime;
            if(_loc2_.showLeftTime)
            {
               this.timeLeftTf.htmlText = _loc2_.leftTimeText;
               App.utils.commons.updateTextFieldSize(this.timeLeftTf,true,false);
               this.itemsOffset = this.calcOffset();
            }
            this.countTF.visible = this.countBg.visible = _loc2_.showCount;
            if(_loc2_.showCount)
            {
               this.countTF.htmlText = _loc2_.countText;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.timeLeftTf = null;
         this.countTF = null;
         this.countBg = null;
         this.qualityIcon.dispose();
         this.qualityIcon = null;
         super.onDispose();
      }
      
      private function calcOffset() : int
      {
         var _loc1_:Number = this.timeLeftTf.width - this._originalTfWidth;
         var _loc2_:int = 0;
         if(_loc1_ < 0)
         {
            this.timeLeftTf.width = this._originalTfWidth;
         }
         else
         {
            _loc2_ = _loc1_ >> 1;
         }
         return _loc2_;
      }
      
      override public function set itemsOffset(param1:int) : void
      {
         super.itemsOffset = param1;
         this.timeLeftTf.width = this._originalTfWidth + (param1 << 1);
      }
   }
}
