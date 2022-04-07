package net.wg.gui.components.advanced
{
   import net.wg.data.VO.ILditInfo;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.IToolTipParams;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public class AdvancedLineDescrIconText extends LineDescrIconText implements IUpdatable
   {
       
      
      private var _toolTipParams:IToolTipParams = null;
      
      private var _data:ILditInfo = null;
      
      public function AdvancedLineDescrIconText()
      {
         super();
      }
      
      override protected function showToolTip(param1:IToolTipParams) : void
      {
         if(tooltip != null && tooltip != Values.EMPTY_STR && this._toolTipParams != null)
         {
            App.toolTipMgr.showComplexWithParams(tooltip,this._toolTipParams);
         }
         else
         {
            super.showToolTip(param1);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         if(this._toolTipParams)
         {
            this._toolTipParams.dispose();
            this._toolTipParams = null;
         }
         super.onDispose();
      }
      
      public function getData() : ILditInfo
      {
         return this._data;
      }
      
      public function setData(param1:ILditInfo) : void
      {
         this._data = param1;
         description = param1.description;
         text = param1.text;
         enabled = param1.enabled;
         tooltip = param1.tooltip;
         this.toolTipParams = param1.toolTipParams;
         iconSource = param1.iconPath;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:ILditInfo = ILditInfo(param1);
         this.setData(_loc2_);
      }
      
      public function set toolTipParams(param1:IToolTipParams) : void
      {
         this._toolTipParams = param1;
      }
   }
}
