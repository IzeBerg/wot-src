package net.wg.gui.lobby.profile.pages.statistics.header
{
   import net.wg.data.VO.ILditInfo;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.data.managers.IToolTipParams;
   import net.wg.gui.lobby.components.data.StatisticsTooltipDataVO;
   
   public class StatisticsHeaderVO extends DAAPIDataClass implements ILditInfo
   {
      
      private static const TOOLTIP_DATA:String = "tooltipData";
       
      
      private var _description:String = "";
      
      private var _text:String = "";
      
      private var _tooltip:String = "";
      
      private var _toolTipParams:IToolTipParams = null;
      
      private var _iconPath:String = "";
      
      private var _enabled:Boolean = true;
      
      public function StatisticsHeaderVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TOOLTIP_DATA && param2)
         {
            this._toolTipParams = new StatisticsTooltipDataVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this._toolTipParams)
         {
            this._toolTipParams.dispose();
            this._toolTipParams = null;
         }
         super.onDispose();
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function set description(param1:String) : void
      {
         this._description = param1;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
      }
      
      public function get toolTipParams() : IToolTipParams
      {
         return this._toolTipParams;
      }
      
      public function set toolTipParams(param1:IToolTipParams) : void
      {
         this._toolTipParams = param1;
      }
      
      public function get iconPath() : String
      {
         return this._iconPath;
      }
      
      public function set iconPath(param1:String) : void
      {
         this._iconPath = param1;
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
      }
   }
}
