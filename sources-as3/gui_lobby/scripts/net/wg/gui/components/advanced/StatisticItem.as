package net.wg.gui.components.advanced
{
   import flash.text.TextField;
   import net.wg.gui.components.advanced.vo.StatisticItemVo;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class StatisticItem extends UIComponentEx
   {
       
      
      public var statValue:TextField = null;
      
      public var statName:TextField = null;
      
      public var icon:UILoaderAlt = null;
      
      private var _data:StatisticItemVo = null;
      
      public function StatisticItem()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function draw() : void
      {
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._data.icon;
            this.statValue.text = this._data.value;
            this.statName.text = this._data.name;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:StatisticItemVo) : void
      {
         this._data = param1;
         invalidateData();
      }
   }
}
