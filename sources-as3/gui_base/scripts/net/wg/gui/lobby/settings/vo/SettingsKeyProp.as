package net.wg.gui.lobby.settings.vo
{
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.ILocale;
   
   public class SettingsKeyProp implements IDisposable
   {
      
      private static const XML_ADD_DISCR_FIRTS_PART:String = " <font size=\"11\" color=\"#615f4f\">";
      
      private static const XML_ADD_DISCR_SECOND_PART:String = "</font><br/>";
      
      private static const HEADER_STR:String = "header";
      
      private static const LABEL_STR:String = "label";
       
      
      public var id:String = null;
      
      public var header:Boolean = false;
      
      public var label:String = null;
      
      public var command:String = null;
      
      public var key:Number = NaN;
      
      public var keyDefault:Number = NaN;
      
      public var keysRang:Array;
      
      public var codependentID:String = null;
      
      private var _disposed:Boolean = false;
      
      public var showUnderline:Boolean = false;
      
      public var rendererYOffset:Number = 0;
      
      public var tooltipID:String;
      
      public function SettingsKeyProp(param1:String = null, param2:Boolean = false, param3:String = null, param4:String = null, param5:Number = NaN, param6:Number = NaN, param7:Array = null, param8:Boolean = false, param9:Number = 0, param10:String = "")
      {
         var _loc12_:int = 0;
         var _loc13_:ILocale = null;
         var _loc14_:uint = 0;
         var _loc15_:String = null;
         var _loc16_:String = null;
         super();
         this.id = param1;
         this.header = param2;
         this.keysRang = !!SettingsConfigHelper.KEY_RANGE.hasOwnProperty(param1) ? SettingsConfigHelper.KEY_RANGE[param1] : SettingsConfigHelper.defaultKeyRange;
         this.codependentID = !!SettingsConfigHelper.CO_DEPENDENTS.hasOwnProperty(param1) ? SettingsConfigHelper.CO_DEPENDENTS[param1] : null;
         var _loc11_:String = null;
         if(param7)
         {
            _loc12_ = param7.length;
            if(_loc12_)
            {
               _loc11_ = Values.EMPTY_STR;
               _loc13_ = App.utils.locale;
               _loc14_ = 0;
               while(_loc14_ < _loc12_)
               {
                  _loc15_ = _loc13_.makeString(param7[_loc14_].hasOwnProperty(HEADER_STR) && param7[_loc14_][HEADER_STR] != undefined ? param7[_loc14_][HEADER_STR] : Values.EMPTY_STR);
                  _loc16_ = _loc13_.makeString(param7[_loc14_].hasOwnProperty(LABEL_STR) && param7[_loc14_][LABEL_STR] != undefined ? param7[_loc14_][LABEL_STR] : Values.EMPTY_STR);
                  _loc11_ += _loc15_ + XML_ADD_DISCR_FIRTS_PART + _loc16_ + XML_ADD_DISCR_SECOND_PART;
                  _loc14_++;
               }
            }
         }
         if(_loc11_)
         {
            this.label = _loc11_;
         }
         else if(param3 != null)
         {
            this.label = App.utils.locale.makeString(!!this.header ? SETTINGS.keyboard_keysblocks_group(param3) : SETTINGS.keyboard_keysblocks_command(param3));
         }
         this.command = param4;
         this.key = param5;
         this.keyDefault = param6;
         this.showUnderline = param8;
         this.rendererYOffset = param9;
         this.tooltipID = param10;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.keysRang = null;
      }
      
      public function getObject() : Object
      {
         return {
            "id":this.id,
            "header":this.header,
            "label":this.label,
            "command":this.command,
            "key":this.key,
            "keyDefault":this.keyDefault,
            "keysRang":this.keysRang,
            "codependentID":this.codependentID,
            "showUnderline":this.showUnderline,
            "rendererYOffset":this.rendererYOffset,
            "tooltipID":this.tooltipID
         };
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
